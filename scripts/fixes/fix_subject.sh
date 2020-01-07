#!/bin/sh
email="$1"
subject="$(gpg -dq $email| grep Subject | head -1)"
echo "$subject"
temp=$(mktemp /tmp/email_XXXXXX)
sed "s/Subject:.*/$subject/g" "$email" > "$temp"
mv "$temp" "$email"

