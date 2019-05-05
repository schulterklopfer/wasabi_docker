#!/usr/bin/expect -f

set timeout -1
spawn /app/start.sh
match_max 100000
expect -exact "Password: "
sleep 1
send -- "test123\r"
expect eof