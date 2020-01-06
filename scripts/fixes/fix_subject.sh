#!/bin/sh
email=`printf "%q" "$1"`
subject=`printf "%q" $(gpg -dq $email| grep Subject | head -1)`
temp=$(mktemp /tmp/email_XXXXXX)
sed "s/Subject:.*/$subject/g" "$email" > "$temp"
mv "$temp" "$email"

