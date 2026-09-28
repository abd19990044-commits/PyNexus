#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
python3 scripts/reassemble.py
apktool d -f build/base.apk -o build/decoded
python3 scripts/normalize_resources.py build/decoded
cp -a overlay/. build/decoded/
apktool b --use-aapt2 build/decoded -o build/PyNexus-unsigned.apk
zipalign -f -p 4 build/PyNexus-unsigned.apk build/PyNexus-aligned.apk

# A durable release key must be kept in GitHub Actions secrets. Without one,
# produce a signed test artifact with a new temporary key for this build only.
if [[ -n "${PYNEXUS_KEYSTORE_B64:-}" && -n "${PYNEXUS_STORE_PASSWORD:-}" ]]; then
    printf '%s' "$PYNEXUS_KEYSTORE_B64" | base64 -d > build/signing.p12
    keystore="build/signing.p12"
    export PYNEXUS_STORE_PASSWORD
else
    keystore="build/temporary-ci-key.p12"
    export PYNEXUS_STORE_PASSWORD="$(python3 -c 'import secrets; print(secrets.token_urlsafe(32))')"
    keytool -genkeypair -noprompt -storetype PKCS12 -keystore "$keystore" \
        -alias pynexus -keyalg RSA -keysize 3072 -validity 10000 \
        -dname 'CN=Abdulsalam Salih Hasan, O=PyNexus' \
        -storepass "$PYNEXUS_STORE_PASSWORD" -keypass "$PYNEXUS_STORE_PASSWORD"
    echo 'TEST SIGNATURE: temporary key; use repository secrets for a stable release signature.'
fi
apksigner sign --ks "$keystore" --ks-key-alias pynexus \
    --ks-pass env:PYNEXUS_STORE_PASSWORD --key-pass env:PYNEXUS_STORE_PASSWORD \
    --out build/PyNexus-signed.apk build/PyNexus-aligned.apk
apksigner verify --verbose --print-certs build/PyNexus-signed.apk
unzip -tqq build/PyNexus-signed.apk
aapt dump badging build/PyNexus-signed.apk | head -8
sha256sum build/PyNexus-signed.apk
