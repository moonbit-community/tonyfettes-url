#!/usr/bin/env python3
"""Collect files for clean MoonBit package publish."""

import shutil
import json
from pathlib import Path

ROOT = Path(__file__).parent.parent
PUBLISH = ROOT / "publish"

# Source files to include (excluding test files)
SOURCE_FILES = [
    "host.mbt",
    "ipv4.mbt",
    "ipv6.mbt",
    "path.mbt",
    "url.mbt",
    "urlsearchparams.mbt",
]


def clean_pkg_json(pkg_json: dict) -> dict:
    """Remove test-import from moon.pkg.json."""
    return {k: v for k, v in pkg_json.items() if k != "test-import"}


def main():
    # 1. Remove existing publish/ folder
    if PUBLISH.exists():
        shutil.rmtree(PUBLISH)
    PUBLISH.mkdir()

    # 2. Copy root files
    shutil.copy(ROOT / "moon.mod.json", PUBLISH / "moon.mod.json")
    shutil.copy(ROOT / "README.md", PUBLISH / "README.md")
    shutil.copy(ROOT / "LICENSE", PUBLISH / "LICENSE")

    # 3. Copy source .mbt files
    for mbt_file in SOURCE_FILES:
        shutil.copy(ROOT / mbt_file, PUBLISH / mbt_file)

    # 4. Copy and clean moon.pkg.json
    pkg_json_path = ROOT / "moon.pkg.json"
    with open(pkg_json_path) as f:
        pkg_json = json.load(f)
    cleaned = clean_pkg_json(pkg_json)
    with open(PUBLISH / "moon.pkg.json", "w") as f:
        json.dump(cleaned, f, indent=2)
        f.write("\n")

    # 5. Print summary
    print(f"Published to {PUBLISH}")
    print("  Files:")
    for f in SOURCE_FILES:
        print(f"    - {f}")


if __name__ == "__main__":
    main()
