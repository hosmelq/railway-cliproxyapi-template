"""Exercise the container without provider accounts or external model requests."""

import json
import secrets
import subprocess
import sys
import time
import urllib.error
import urllib.request
import uuid

admin_key = secrets.token_hex(32)
containers = []
image = sys.argv[1]
initial_key = secrets.token_hex(32)
prefix = "cliproxy-smoke-" + uuid.uuid4().hex[:12]
replacement_admin = secrets.token_hex(32)
replacement_key = secrets.token_hex(32)
saved_key = secrets.token_hex(32)
volume = prefix + "-data"


def docker(*args, check=True):
    return subprocess.run(
        ["docker", *args], check=check, capture_output=True, text=True
    )


def request(base, path, key=None, body=None, method=None):
    headers = {"Content-Type": "application/json"}
    if key:
        headers["Authorization"] = "Bearer " + key
    req = urllib.request.Request(
        base + path,
        headers=headers,
        method=method,
        data=None if body is None else json.dumps(body).encode(),
    )
    try:
        with urllib.request.urlopen(req, timeout=5) as response:
            raw = response.read()
            return response.status, json.loads(raw) if raw else None
    except urllib.error.HTTPError as error:
        return error.code, None


def start(suffix, client, admin):
    name = prefix + "-" + suffix
    docker(
        "run",
        "-d",
        "--rm",
        "--name",
        name,
        "-p",
        "127.0.0.1::8317",
        "-v",
        volume + ":/data",
        "-e",
        "CLIPROXY_API_KEY=" + client,
        "-e",
        "MANAGEMENT_PASSWORD=" + admin,
        image,
    )
    containers.append(name)
    address = docker("port", name, "8317/tcp").stdout.strip()
    base = "http://" + address
    for _ in range(100):
        try:
            if request(base, "/healthz")[0] == 200:
                return name, base
        except (OSError, urllib.error.URLError):
            pass
        time.sleep(0.2)
    raise AssertionError("Container did not become healthy")


try:
    docker("volume", "create", volume)
    for label, env in [
        (
            "invalid port",
            [
                "CLIPROXY_API_KEY=" + initial_key,
                "MANAGEMENT_PASSWORD=" + admin_key,
                "PORT=0",
            ],
        ),
        ("missing initial client key", ["MANAGEMENT_PASSWORD=" + admin_key]),
        ("missing management key", []),
        ("short management key", ["MANAGEMENT_PASSWORD=short"]),
        (
            "unsafe client key",
            [
                "CLIPROXY_API_KEY=" + initial_key + '"',
                "MANAGEMENT_PASSWORD=" + admin_key,
            ],
        ),
    ]:
        args = ["run", "--rm"]
        for value in env:
            args += ["-e", value]
        result = docker(*args, image, check=False)
        assert result.returncode != 0, label + " was accepted"

    name, base = start("first", initial_key, admin_key)
    assert request(base, "/v1/models")[0] == 401
    assert request(base, "/v1/models", initial_key)[0] == 200
    assert request(base, "/v1/models", admin_key)[0] == 401
    assert request(base, "/v8/management/config", initial_key)[0] == 401
    status, config = request(base, "/v8/management/config", admin_key)
    assert status == 200
    assert config["routing"]["session-affinity"] is True
    assert config["oauth"]["auth-dir"] == "/data/auths"

    status, _ = request(
        base,
        "/v8/management/config",
        admin_key,
        {
            "access": {"api-keys": [saved_key]},
            "routing": {"session-affinity-ttl": "17h"},
        },
        "PATCH",
    )
    assert status == 200
    assert request(base, "/v8/management/config", admin_key)[1]["access"][
        "api-keys"
    ] == [saved_key]
    docker("exec", name, "sh", "-c", "printf persisted > /data/auths/persistence.txt")
    assert (
        docker("exec", name, "stat", "-c", "%a", "/data/config.yaml").stdout.strip()
        == "600"
    )
    docker("stop", name)
    containers.remove(name)

    name, base = start("second", replacement_key, replacement_admin)
    status, config = request(base, "/v8/management/config", replacement_admin)
    assert status == 200
    assert config["routing"]["session-affinity-ttl"] == "17h"
    assert request(base, "/v1/models", saved_key)[0] == 200
    assert request(base, "/v1/models", initial_key)[0] == 401
    assert request(base, "/v1/models", replacement_key)[0] == 401
    assert request(base, "/v8/management/config", admin_key)[0] == 401
    assert (
        docker("exec", name, "cat", "/data/auths/persistence.txt").stdout == "persisted"
    )
    print(
        "Authentication, key rotation, saved configuration, and volume persistence passed."
    )
finally:
    for name in containers:
        docker("stop", name, check=False)
    docker("volume", "rm", volume, check=False)
