#!/bin/bash

# Defina o diretório base fixo para o seu repositório Git na home
BASE_DIR="${HOME}/git"  # Substitua por sua pasta Git real

# Verifica se a pasta base existe
if [ ! -d "$BASE_DIR" ]; then
  echo "O diretório $BASE_DIR não existe. Saindo..."
  exit 1
fi

# Use 'fd' para listar diretórios até dois níveis de profundidade e 'fzf' para selecionar
DIR=$(fd -H -td -d 2 . "$BASE_DIR" | fzf --prompt="Selecione um diretório: ")

# Verifica se o usuário selecionou um diretório ou cancelou a seleção
if [ -z "$DIR" ]; then
  echo "Nenhum diretório selecionado. Saindo..."
  exit 1
fi

# Nome da sessão tmux com base no diretório escolhido
SESSION_NAME=$(basename "$DIR")

# Certifique-se de que o nome da sessão tmux seja válido (evitar problemas com caracteres especiais)
SESSION_NAME=$(echo "$SESSION_NAME" | sed 's/[^a-zA-Z0-9_-]/_/g')

# Verifica se já estamos dentro de uma sessão tmux
if [ -z "$TMUX" ]; then
  # Se não estamos dentro de uma sessão tmux, cria ou entra em uma nova sessão
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Se a sessão já existir, entra nela
    tmux attach -t "$SESSION_NAME"
  else
    # Se a sessão não existir, cria uma nova sessão no diretório
    tmux new-session -d -s "$SESSION_NAME" -c "$DIR"
    tmux attach -t "$SESSION_NAME"
  fi
else
  # Se já estamos dentro de uma sessão tmux, apenas cria ou entra na sessão com o nome escolhido
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Se a sessão já existir, entra nela
    tmux switch-client -t "$SESSION_NAME"
  else
    # Se a sessão não existir, cria uma nova sessão no diretório
    tmux new-session -d -s "$SESSION_NAME" -c "$DIR"
    tmux switch-client -t "$SESSION_NAME"
  fi
fi

