# helm chart for an LDAP proxy for freeipa

This chart is based on 389ds, the LDAP server driving 389ds. It is used as a proxy for HA for applications that support only a single LDAP server definition for authentication.

Documentation of values possible are in the values.yml file in the project.

## Mandatory setup for freeipa

As the proxy requires to authenticate the user and then transmit the user info to the freeipa instance, the proxy needs to be authenticated with a user having specific rights on the freeipa backend.

The ACI to `proxy` the users needs to be given to the user the proxy will use to authenticate to the freeipa backend.

To setup the right you need to create an ACI on the root of the freeipa LDAP directory. The easiest way to make it manageable, is to go in the WebUI and create a new role in the "IPA Server" tab. After having created the new role, you can add Users and Service accounts to it. Then you need to actually give the permissions to the Role. It cannot be done using the WebUI so you need to apply an LDIF similar to this one directly via ldapmodify:
```
dn: dc=example,dc=com
changetype: modify
add: aci
aci: (targetattr="*")(version 3.0 ; acl "Proxied authorization for database links" ; allow (proxy) groupdn = "ldap:///cn=LDAP Proxy Authentication,cn=roles,cn=accounts,dc=example,dc=com";)
```

Replacing `dc=example,dc=com` with the correct baseDN, and `LDAP Proxy Authentication` with the name you gave to the role.

Note that, since the right gives the possibility to impersonate any user of the LDAP (including `cn=Directory Manager` !) you need to trust the account completely to give this right.
