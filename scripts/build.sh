#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
BUILD_DIR="build"
DECODED_DIR="$BUILD_DIR/decoded"
UNSIGNED="$BUILD_DIR/PyNexus-unsigned.apk"
ALIGNED="$BUILD_DIR/PyNexus-aligned.apk"
SIGNED="$BUILD_DIR/PyNexus-signed.apk"
rm -rf "$DECODED_DIR" "$UNSIGNED" "$ALIGNED" "$SIGNED"
mkdir -p "$BUILD_DIR"
require_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "ERROR: required command not found: $1" >&2; exit 127; }; }
for cmd in python3 java apktool aapt aapt2 zipalign apksigner; do require_cmd "$cmd"; done
echo "[1/7] Reassembling and verifying base APK"
python3 scripts/reassemble.py
echo "[2/7] Decoding base APK"
apktool d -f "$BUILD_DIR/base.apk" -o "$DECODED_DIR"
echo "[3/7] Normalizing resources"
python3 scripts/normalize_resources.py "$DECODED_DIR"
echo "[4/7] Applying PyNexus overlay"
cp -a overlay/. "$DECODED_DIR/"
echo "[5/7] Rebuilding and aligning"
apktool b --use-aapt2 "$DECODED_DIR" -o "$UNSIGNED"
zipalign -f -p 4 "$UNSIGNED" "$ALIGNED"
zipalign -c -P 4 -v 4 "$ALIGNED"
echo "[6/7] Signing"
if [[ -n "${PYNEXUS_KEYSTORE_B64:-}" && -n "${PYNEXUS_STORE_PASSWORD:-}" ]]; then
  printf "%s" "$PYNEXUS_KEYSTORE_B64" | base64 -d > "$BUILD_DIR/signing.p12"
  keystore="$BUILD_DIR/signing.p12"
  echo "Using repository-provided release keystore."
else
  keystore="$BUILD_DIR/temporary-ci-key.p12"
  export PYNEXUS_STORE_PASSWORD="$(python3 -c 'import secrets; print(secrets.token_urlsafe(32))')"
  keytool -genkeypair -noprompt -storetype PKCS12 -keystore "$keystore" -alias pynexus -keyalg RSA -keysize 3072 -validity 10000 -dname "CN=Abdulsalam Salih Hasan, O=PyNexus" -storepass "$PYNEXUS_STORE_PASSWORD" -keypass "$PYNEXUS_STORE_PASSWORD"
  echo "Using an ephemeral CI test key; configure repository secrets for release signing."
fi
apksigner sign --ks "$keystore" --ks-key-alias pynexus --ks-pass env:PYNEXUS_STORE_PASSWORD --key-pass env:PYNEXUS_STORE_PASSWORD --out "$SIGNED" "$ALIGNED"
echo "[7/7] Verifying final APK"
apksigner verify --verbose --print-certs "$SIGNED"
unzip -tqq "$SIGNED"
aapt dump badging "$SIGNED" | head -8
sha256sum "$SIGNED"
echo "Build complete: $SIGNED"
