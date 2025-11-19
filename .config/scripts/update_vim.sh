#!/bin/zsh

# Defina o diretório desejado
DIR="${HOME}/git/personal/neovim"  # Substitua por sua pasta Git real

# Navegar até o diretório
cd "$DIR" || { echo "Diretório não encontrado!"; exit 1; }

# Remover a pasta build se existir
if [ -d "./build" ]; then
    sudo rm -r ./build
else
    echo "Pasta ./build não existe, pulando remoção."
fi
# Fazer o pull do repositório
if [ $(git rev-parse HEAD) = $(git rev-parse @{u}) ]; then
    echo "Não há mudanças no repositório."
    exit 0
else
    echo "Novas mudanças encontradas. Fazendo pull."
    git pull
fi

# Compilar o projeto com CMake
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo

# Mudar para o diretório build
cd build || { echo "Diretório build não encontrado!"; exit 1; }

# Obter a arquitetura do sistema
ARCH=$(dpkg --print-architecture)
ARCH=$(dpkg --print-architecture)
ARCH=${ARCH/amd64/x86_64}

# Criar o pacote DEB
sudo cpack -G DEB

# Instalar o pacote DEB gerado
sudo dpkg -i "nvim-linux-${ARCH}.deb"

