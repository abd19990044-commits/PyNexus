#!/usr/bin/env python3
"""Reassemble the exact APK provided by the owner and reject incomplete parts."""
from hashlib import sha256
from pathlib import Path

root = Path(__file__).resolve().parents[1]
parts = sorted((root / "vendor").glob("base.apk.part*"))
assert len(parts) == 92, f"expected 92 APK parts, found {len(parts)}"
digest = sha256()
with (root / "build" / "base.apk").open("wb") as dest:
    for part in parts:
        data = part.read_bytes()
        digest.update(data)
        dest.write(data)
expected = "2e37c85716e41039f68c45841fa5ed381d4d4c090f79c9e3289ec29e5766c4a8"
assert digest.hexdigest() == expected, "APK checksum mismatch"
print("base APK checksum verified:", digest.hexdigest())
