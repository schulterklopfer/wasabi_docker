#!/usr/bin/env sh

command=$1
password=$(cat -) # will block until input from stdin

if [ "$command" = "" ]; then
    command="mix"
fi

if [ "$command" = "mix" ]; then
  # TODO: first testpassword and exit if wrong
  # or else the next command will hang on a wrong
  # password
  exec /app/startWasabiWalletWithPassword.sh $2 ${password,""}
elif [ "$command" = "createWallet" ]; then
  exec /app/generateWallet.sh $2 ${password,""}
else
  echo "Unknown command"
fi

