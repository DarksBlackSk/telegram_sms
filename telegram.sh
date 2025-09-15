#!/bin/bash
TOKEN="TOKE DEL BOT"
OFFSET=0
API_URL="https://api.telegram.org/bot$TOKEN"
FILE_URL="https://api.telegram.org/file/bot$TOKEN"
TIMEOUT=10
RETRY_DELAY=5
DOWNLOAD_DIR="./downloads"

mkdir -p "$DOWNLOAD_DIR"

jq_validator() {

    dpkg --list | awk '{print $2}' | grep -w 'jq' 2>&1 >/dev/null
    validator=$(echo $?)
    if [[ "$validator" = 1 ]]; then
         echo -e "jq no esta instalado en el sistema.\nInstalacion: sudo apt install jq -y"
         exit
    fi
}

jq_validator

process_updates() {
    local response=$(curl -s "$API_URL/getUpdates?offset=$OFFSET&timeout=$TIMEOUT")
    
    # Verificar respuesta
    local ok=$(echo "$response" | jq -r '.ok')
    if [ "$ok" != "true" ]; then
        echo "Error en la respuesta de la API"
        sleep $RETRY_DELAY
        return 1
    fi
    
    local updates=$(echo "$response" | jq -c '.result[]')
    if [ -z "$updates" ]; then
        return 0
    fi
    
    # Procesar cada update
    while IFS= read -r update; do
        local update_id=$(echo "$update" | jq -r '.update_id')
        local username=$(echo "$update" | jq -r '.message.from.username // "desconocido"')
        local text=$(echo "$update" | jq -r '.message.text // empty')
        
        # Mostrar mensajes de texto (con emojis, UTF-8, etc.)
        if [ -n "$text" ]; then
            echo "[@$username] $text"
        fi
        
        # Manejar archivos adjuntos
        for type in photo document audio video voice; do
            local file_id=$(echo "$update" | jq -r ".message.$type | if type==\"array\" then .[-1].file_id else .file_id end // empty")
            if [ -n "$file_id" ]; then
                echo "[$username] envió un archivo ($type)"
                # Obtener ruta de descarga
                local file_path=$(curl -s "$API_URL/getFile?file_id=$file_id" | jq -r '.result.file_path')
                if [ "$file_path" != "null" ]; then
                    local filename=$(basename "$file_path")
                    curl -s -o "$DOWNLOAD_DIR/$filename" "$FILE_URL/$file_path"
                    echo "Archivo descargado en: $DOWNLOAD_DIR/$filename"
                fi
            fi
        done
        
        OFFSET=$((update_id + 1))
    done <<< "$updates"
}

echo "Bot iniciado. Esperando mensajes..."
while true; do
    process_updates
    sleep 0.5
done
