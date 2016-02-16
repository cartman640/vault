# drunner/vault #

A dService to run Hashicorp Vault.  It's configured to use the disk backend.

Currently supports the init, unseal, auth, write and read commands

See http://drunner.io for more information about dRunner.

# Example use #

~~~
drunner install infmon/vault
vault init
vault unseal
~~~
