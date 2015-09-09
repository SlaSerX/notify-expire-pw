Small bash script to notify users about soon(<NOTIFY_DAYS) password expiration. Email address is taken from comment(GECOS) in user's properties. `mail` utility is used to send notifications.

Only users with id>MIN_ID and with proper mail addares in comment are checked.
