#!/usr/bin/env bash

set -e

if [ -n "$ANDROID_BUILD_TOP" ] && [ -d "$ANDROID_BUILD_TOP/device/lineage/sepolicy" ]; then
    TOP_DIR="$ANDROID_BUILD_TOP"
else
    CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    while [ "$CURRENT_DIR" != "/" ]; do
        if [ -d "$CURRENT_DIR/device/lineage/sepolicy" ]; then
            TOP_DIR="$CURRENT_DIR"
            break
        fi
        CURRENT_DIR="$(dirname "$CURRENT_DIR")"
    done
fi

if [ -z "$TOP_DIR" ]; then
    exit 0
fi

SEPOLICY_DIR="$TOP_DIR/device/lineage/sepolicy/common/private"
if [ ! -d "$SEPOLICY_DIR" ]; then
    exit 0
fi

MODE="${1:---apply}"

check_and_patch_file() {
    local file_path="$1"
    local pattern="$2"
    local append_content="$3"

    if [ ! -f "$file_path" ]; then
        mkdir -p "$(dirname "$file_path")"
        echo -e "$append_content" > "$file_path"
        return
    fi

    if ! grep -qF "$pattern" "$file_path"; then
        if [ "$MODE" != "--check" ]; then
            echo -e "\n$append_content" >> "$file_path"
        fi
    fi
}

SERVICE_TE="$SEPOLICY_DIR/service.te"
SERVICE_RULE="type lmo_freeform_service, app_api_service, system_api_service, system_server_service, service_manager_type;"
check_and_patch_file "$SERVICE_TE" "lmo_freeform_service" "$SERVICE_RULE"

CONTEXTS_FILE="$SEPOLICY_DIR/service_contexts"
CONTEXT_RULE="lmo_freeform                              u:object_r:lmo_freeform_service:s0"
check_and_patch_file "$CONTEXTS_FILE" "lmo_freeform" "$CONTEXT_RULE"

SHELL_TE="$SEPOLICY_DIR/shell.te"
SHELL_RULE="allow shell lmo_freeform_service:service_manager find;"
check_and_patch_file "$SHELL_TE" "allow shell lmo_freeform_service:service_manager find;" "$SHELL_RULE"
