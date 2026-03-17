#!/bin/bash

NOCTALIA_CONFIG="$HOME/.config/noctalia/settings.json"

if [[ ! -f "$NOCTALIA_CONFIG" ]]; then
    notify-send -u critical "Erro" "Configuração não encontrada"
    exit 1
fi

# Backup (sempre sobrescreve o mesmo arquivo)
cp "$NOCTALIA_CONFIG" "$NOCTALIA_CONFIG.bak"

# Usa Python para alterar especificamente o displayMode dentro de "bar"
python3 << EOF
import json
import os

config_file = "$NOCTALIA_CONFIG"

# Lê o arquivo
with open(config_file, 'r') as f:
    config = json.load(f)

# Pega o modo atual da bar
current_mode = config.get("bar", {}).get("displayMode", "always_visible")
print(f"Modo atual da bar: {current_mode}")

# Alterna o modo
if current_mode == "always_visible":
    new_mode = "auto_hide"
    msg = "Auto-hide"
else:
    new_mode = "always_visible"
    msg = "Sempre visível"

# Altera apenas o displayMode dentro de "bar"
config["bar"]["displayMode"] = new_mode

# Salva o arquivo
with open(config_file, 'w') as f:
    json.dump(config, f, indent=4)

print(f"Novo modo da bar: {new_mode}")
EOF

# Notifica o resultado
if [[ $? -eq 0 ]]; then
    # Extrai o novo modo para notificação
    NEW_MODE=$(python3 -c "import json; f=open('$NOCTALIA_CONFIG'); d=json.load(f); print(d.get('bar', {}).get('displayMode', 'unknown'))" 2>/dev/null)

    if [[ "$NEW_MODE" == "auto_hide" ]]; then
        //notify-send -t 2000 "Noctalia Bar" "Modo: Auto-hide"
    elif [[ "$NEW_MODE" == "always_visible" ]]; then
        //notify-send -t 2000 "Noctalia Bar" "Modo: Sempre visível"
    else
        notify-send -u normal "Noctalia Bar" "Modo alterado (verifique)"
    fi

    # Tenta recarregar a Noctalia
    pkill -SIGUSR1 noctalia 2>/dev/null || true
else
    notify-send -u critical "Erro" "Falha ao alterar configuração"
    exit 1
fi
