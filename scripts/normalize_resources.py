#!/usr/bin/env python3
"""Rename apktool's generated $ drawables for aapt2, keeping resource IDs."""
from pathlib import Path
import sys


def normalize(root: Path) -> None:
    res = root / "res"
    names = {}
    for path in (res / "drawable").glob("$*.xml"):
        new_name = "aapt2_" + path.stem[1:]
        names[path.stem] = new_name
        path.rename(path.with_name(new_name + path.suffix))
    if len(names) != 40:
        raise RuntimeError(f"expected 40 generated drawables, got {len(names)}")
    for path in res.rglob("*.xml"):
        data = path.read_text(encoding="utf-8")
        revised = data
        for old, new in names.items():
            revised = revised.replace("@drawable/" + old, "@drawable/" + new)
            revised = revised.replace('name="' + old + '"', 'name="' + new + '"')
        if revised != data:
            path.write_text(revised, encoding="utf-8")


if __name__ == "__main__":
    normalize(Path(sys.argv[1]))
