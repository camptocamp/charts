# Apache 2 ldap reverse proxy

This is considered more stable that then nginx plugin

## Binding to the LDAP server Login/Password

You need a secret with two values : binddn/password. 
The secret is formated as follow: 
apiVersion: v1
data:
  password: base64(password)
  login: base64("cn=binddn,ou=service,o=company,c=com")
kind: Secret
metadata:
  name: mybinddn

