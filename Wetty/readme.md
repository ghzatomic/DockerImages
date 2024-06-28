# Configuração do Contêiner com Nginx, Wetty, Code-Server e OpenVPN

Este projeto configura um contêiner Docker com Nginx, Wetty, Code-Server e OpenVPN.

## Instruções para Conectar à VPN no Windows

### Pré-requisitos

1. Baixe e instale o [OpenVPN Client](https://openvpn.net/client-connect-vpn-for-windows/).

### Configuração do Cliente OpenVPN

1. Obtenha os seguintes arquivos do servidor VPN:
   - `ca.crt`
   - `client.crt`
   - `client.key`
   - `client.ovpn` (arquivo de configuração do cliente OpenVPN)

2. Coloque esses arquivos em um diretório, por exemplo, `C:\OpenVPN\config`.

3. Abra o arquivo `client.ovpn` em um editor de texto e configure conforme necessário. Certifique-se de que os caminhos para os arquivos `ca.crt`, `client.crt`, e `client.key` estão corretos.

   Exemplo de `client.ovpn`:




openvpn --config /etc/openvpn/server.conf