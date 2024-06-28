FROM ubuntu:latest

# Instale dependências
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nodejs \
    npm \
    openssh-server \
    wget \
    software-properties-common \
    build-essential \
    nginx \
    sudo \
    openvpn \
    easy-rsa \
    cmake \
    libjson-c-dev \
    libwebsockets-dev \
    libuv1-dev

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
    n v18.19.1

# Instale ttyd
RUN git clone https://github.com/tsl0922/ttyd.git /ttyd && \
    cd /ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# Crie um usuário para login e adicione ao grupo sudo
RUN useradd -ms /bin/bash caio && echo 'caio:123' | chpasswd && usermod -aG sudo caio

RUN echo "caio:$(id -u caio)" > /etc/ttyd-uid

# Instale code-server
RUN wget https://github.com/coder/code-server/releases/download/v4.0.1/code-server-4.0.1-linux-amd64.tar.gz \
    && tar -xzvf code-server-4.0.1-linux-amd64.tar.gz \
    && mv code-server-4.0.1-linux-amd64 /usr/local/lib/code-server \
    && ln -s /usr/local/lib/code-server/bin/code-server /usr/local/bin/code-server

# Copie o script de inicialização e dê permissão para execução
COPY init_openvpn.sh /usr/local/bin/init_openvpn.sh
RUN chmod +x /usr/local/bin/init_openvpn.sh

# Exponha as portas necessárias
EXPOSE 80 3001 8080 1194/udp

# Comando para iniciar Nginx, ttyd, code-server e gerar certificados OpenVPN
#CMD ["sh", "-c", "nginx -g 'daemon off;' & ttyd -p 3001 -W -c caio:123 -u $(cut -d: -f2 /etc/ttyd-uid) bash & code-server --bind-addr 0.0.0.0:8080 --auth none "]
CMD ["sh", "-c", "nginx -g 'daemon off;' & ttyd -p 3001 -W -u $(cut -d: -f2 /etc/ttyd-uid) bash & code-server --bind-addr 0.0.0.0:8080 --auth none "]
