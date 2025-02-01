## FROM: https://adamtheautomator.com/winrm-for-ansible/
## This is the public key generated from the Ansible server using:
cat > openssl.conf << EOL
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req_client]
extendedKeyUsage = clientAuth
subjectAltName = otherName:1.3.6.1.4.1.311.20.2.3;UTF8:ansibletestuser@localhost
EOL
export OPENSSL_CONF=openssl.conf
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -out cert.pem -outform PEM -keyout cert_key.pem -subj "/CN=ansibletestuser" -extensions v3_req_client
rm openssl.conf 
