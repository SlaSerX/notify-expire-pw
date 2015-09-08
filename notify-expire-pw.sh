#!/bin/bash
NOTIFY_DAYS=7
MIN_ID=1000

IFS='
'
users=$( getent passwd )
for user in $users; do
  id=$( echo $user | cut -d':' -f3 )
  test "$id" -lt $MIN_ID && continue
  comment=$( echo $user | cut -d: -f5 )
  echo $comment | grep -q '@' || continue
  name=$( echo $user | cut -d: -f1 )
  expires=$( getent shadow $name | cut -d: -f3 )
  if [ "$expires" -lt "$NOTIFY_DAYS" ]; then
    subject="WARNING: $name password on $(hostname) expires in $expires days"
    body="How to change password: http://wiki.unitpay.ru/vpn"
    echo "$body" |  mail -s i"$subject" "$comment"
fi
done
