#!/bin/bash

EASYRSA_DIR="/etc/openvpn/easy-rsa"
CERTS_DIR="/etc/openvpn/servercerts"

# Inicializar o diretório easy-rsa
make-cadir $EASYRSA_DIR
cd $EASYRSA_DIR

# Configurar vars
echo "set_var EASYRSA_REQ_COUNTRY    \"US\"" > vars
echo "set_var EASYRSA_REQ_PROVINCE   \"California\"" >> vars
echo "set_var EASYRSA_REQ_CITY       \"San Francisco\"" >> vars
echo "set_var EASYRSA_REQ_ORG        \"MyCompany\"" >> vars
echo "set_var EASYRSA_REQ_EMAIL      \"admin@mycompany.com\"" >> vars
echo "set_var EASYRSA_REQ_OU         \"MyOrganizationalUnit\"" >> vars
echo "set_var EASYRSA_PKI            \"$EASYRSA_DIR/pki\"" >> vars

# Construir CA, servidor e chave Diffie-Hellman
./easyrsa init-pki
./easyrsa --batch build-ca nopass
./easyrsa gen-req server nopass
./easyrsa --batch sign-req server server
./easyrsa gen-dh

# Mover certificados para o diretório compartilhado
mkdir -p $CERTS_DIR
cp pki/ca.crt pki/issued/server.crt pki/private/server.key pki/dh.pem $CERTS_DIR

# Copiar certificados para o diretório do OpenVPN
cp $CERTS_DIR/* /etc/openvpn/
