#!/bin/bash
BACKUP_NAME="vps_backup.tar.gz"
BACKUP_URL="https://transfer.sh/vps_backup.tar.gz"

function restore_backup() {
    echo "🔄 Restoring backup..."
    curl -L --fail $BACKUP_URL -o $BACKUP_NAME || {
        echo "No previous backup found."
        return 1
    }
    tar -xpf $BACKUP_NAME || echo "Failed to extract."
}

function backup_and_upload() {
    echo "📤 Uploading backup..."
    tar -cpf $BACKUP_NAME ./data ./scripts 2>/dev/null
    UPLOAD_LINK=$(curl --upload-file $BACKUP_NAME https://transfer.sh/$BACKUP_NAME)
    echo "✅ Link: $UPLOAD_LINK"
}

if [ "$1" == "restore_backup" ]; then
    restore_backup
elif [ "$1" == "backup_and_upload" ]; then
    backup_and_upload
fi

