FROM ubuntu:latest

# Instale dependências
RUN apt-get update && apt-get install -y \
    curl \
    git \
    openssh-server \
    wget \
    software-properties-common \
    build-essential \
    openssh-client \
    certbot \
    python3-certbot-nginx

# Instale Python 3.11
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev python3.11-distutils && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1

# Instale Java (OpenJDK 17, que é a versão LTS mais recente)
RUN apt-get install -y openjdk-17-jdk

# Instale o gerenciador de pacotes `n` e a última versão do Node.js
RUN curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o /usr/local/bin/n && \
    chmod +x /usr/local/bin/n && \
    n 18

# Remova o Node.js instalado pelo apt para evitar conflitos
#RUN apt-get remove -y nodejs npm

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
EXPOSE 3001 8080
# Obter certificado SSL com Certbot
run curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
run pip install cffi

# Comando para iniciar todos os serviços
CMD ["sh", "-c", "wetty --port 3001 --ssh-host host.docker.internal --ssh-user testuser & code-server --bind-addr 0.0.0.0:8080 --auth none"]
