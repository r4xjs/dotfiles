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

# Unblock PIN
<!-- {{{1 -->
Option 1:
```
gpg --edit-card
> admin
> passwd
> 2
```

Option 2:
```
ykman piv unblock-pin
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
https://blogg.spofify.se/index.php/2020/09/05/use-yubikey-for-sudo-authentication/

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

for i3lock, make sure that `u2f_mappings` file is readable by the user

<!-- 1}}} --> 

# GPG
<!-- {{{1 -->
enable touch policy:
https://developers.yubico.com/PGP/Card_edit.html

new master:
```
gpg --expert --full-generate-key
8
E
S
Q
2048
0
y
```

new sub keys:
```
gpg --expert --edit-key $keyid
addkey
4
2048
1y
y
y
addkey
6
2048
1y
y
y
addkey
8
S
E
A
Q
2048
1y
y
y
save
```

export secret master and sub keys as backup:
```
gpg -a --export-secret-keys $keyid > master.key
gpg -a --export-secret-subkeys $keyid > sub.key
gpg -a --export $keyid > pub.key
```

transfere sub keys to yubikey:
```
gpg --edit-key $keyid
key 1
keytocard
key 1
key 2
keytocard
key 2
key 3
keytocard
save
```

to use on new machine just import pub.key
```
gpg --import pub.key
gpg --card-status
gpg --list-keys
gpg --list-secret-keys
```

to use the second yubikey:
```
rm -rf ~/.gnupg/private-keys-v1.d
gpgconf --kill gpg-agent
gpg --card-status
```

use gpg key as ssh key:
```
gpg --list-keys --with-keygrip 
export Keygrip=...authentication sub key...
echo $Keygrip > ~/.gnupg/sshcontrol

cat ~/.gnupg/gpg-agent.conf
enable-ssh-support
default-cache-ttl 60
max-cache-ttl 120
pinentry-program /usr/bin/pinentry-gtk-2

cat ~/.zshrc
...
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
...

ssh-add -L
<ssh public key here>

```

<!-- 1}}} --> 

# udev
<!-- {{{1 -->

/etc/udev/rules.de/90-yubikey.rules
```
ACTION=="remove", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="xxx", ENV{ID_VENDOR_ID}=="xxx", ENV{ID_SERIAL}=="xxxx", RUN+="/usr/bin/systemctl start --no-block i3lock.service"
ACTION=="add", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="xxx", ENV{ID_VENDOR_ID}=="xxx", ENV{ID_SERIAL}=="xxx", RUN+="/bin/su user /bin/sh -c '/usr/bin/gpg --card-status > /dev/null'" 
```

reload rules:
```
sudo udevadm control -R
```

find out parameter via:
```
sudo udevadm monitor --environment --udev
```

systemd service:
```
[Unit]
Description=i3lock

[Service]
User=<username>
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock -c 090920 -d 
```


<!-- 1}}} --> 

