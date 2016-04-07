Small bash script to notify users about soon(<NOTIFY_DAYS) password expiration. Email address is taken from comment(GECOS) in user's properties. `mail` utility is used to send notifications.

Only users with id>MIN_ID and with proper mail addares in comment are checked.

**P.S.** If this code is useful for you - don't forget to put a star on it's [github repo](https://github.com/selivan/notify-expire-pw).
