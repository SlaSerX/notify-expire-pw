#!/bin/bash
#set -x
NOTIFY_DAYS=7
MIN_ID=1000

for util in getent mail date hostname; do
        which $util > /dev/null || { echo "ERROR: no $util in PATH"; exit 1; }
done

IFS='
'
users=$( getent passwd )
currentdays=$(($(date +%s)/3600/24))
for user in $users; do

id=$( echo $user | cut -d':' -f3 )
test "$id" -lt $MIN_ID && continue
comment=$( echo $user | cut -d: -f5 )
echo $comment | grep -q '@' || continue
name=$( echo $user | cut -d: -f1 )
echo "Checking user $name"
lastchanged=$( getent shadow $name | cut -d: -f3 )
changeafter=$( getent shadow $name | cut -d: -f5 )
expires=$(( $currentdays + $changeafter - $lastchanged ))
if [ "$expires" -lt "$NOTIFY_DAYS" ]; then
        subject="WARNING: $name password on $(hostname) expires in $expires days"
        body="How to change password: http://wiki.unitpay.ru/vpn"
        echo "$body" |  mail -s "$subject" "$comment"
        echo "Notification mail sent to $comment"
fi
done
