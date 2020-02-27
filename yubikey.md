# Setup PIV
<!-- {{{1 -->

```
key=$(export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -d '[:lower:]' | tr -cd '[:xdigit:]' | fold -w48 | head -1)
echo ${key}
yubico-piv-tool -aset-mgm-key -n${key}
pin=$(export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -cd '[:digit:]' | fold -w6 | head -1)
echo ${pin}
puk=$(export LC_CTYPE=C; dd if=/dev/urandom 2>/dev/null | tr -cd '[:digit:]' | fold -w8 | head -1)
echo ${puk}
yubico-piv-tool -achange-pin -P123456 -N${pin}
yubico-piv-tool -achange-puk -P12345678 -N${puk}
```

<!-- 1}}} --> 

# SSH
<!-- {{{1 -->

generate private key on yubikey and output public key to filesystem, gen self-signed cert
```
ykman piv generate-key --touch-policy=always -m $MK -a RSA2048 9a pubkey.pem
ykman piv generate-certificate -m $MK  -s "SSH Key" 9a pubkey.pem
```

convert from PEM to RFC 4253 (ssh key format):
```
ssh-keygen -i -m PKCS8 -f pubkey.pem > pubkey.txt
```

in ~/.ssh/config
```
replace `IdentityFile ~/.ssh/f00` with
PKCS11Provider /usr/lib/opensc-pkcs11.so
```

need opensc package on the client for this to work.


<!-- 1}}} --> 

# PAM
<!-- {{{1 -->
create `u2f_mappings` file
```
pamu2fcfg -u `whoami` -opam://`hostname` -ipam://`hostname`
```
will output in the following format:
```
username:keyhandle,key
```
repeat with other yubikeys and copy output to one line per user to the `u2f_mappings` file:
```
username:keyhandle1,key1:keyhandle2,key2
```

/etc/pam.d/whatever
```
auth sufficient pam_u2f.so origin=pam://<HOSTNAME> appid=pam://<HOSTNAME> authfile=</path/to/u2f_mappings>
or
auth required pam_u2f.so origin=pam://<HOSTNAME> appid=pam://<HOSTNAME> authfile=</path/to/u2f_mappings>
auth include system-auth
```
<!-- 1}}} --> 
