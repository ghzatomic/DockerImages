FROM ubuntu:latest

# Instale dependências
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    openssh-server \
    wget

# Instale Wetty
RUN npm install -g wetty

# Crie um usuário para login
RUN useradd -ms /bin/bash caio && echo 'caio:123' | chpasswd

# Instale code-server
RUN wget https://github.com/coder/code-server/releases/download/v4.0.1/code-server-4.0.1-linux-amd64.tar.gz \
    && tar -xzvf code-server-4.0.1-linux-amd64.tar.gz \
    && mv code-server-4.0.1-linux-amd64 /usr/local/lib/code-server \
    && ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server

# Exponha as portas necessárias
EXPOSE 3000 8080

# Comando para iniciar Wetty e code-server
CMD ["sh", "-c", "wetty --port 3000 --ssh-host localhost --ssh-user testuser & code-server --bind-addr 0.0.0.0:8080 --auth none"]

