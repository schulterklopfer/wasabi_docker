#!/usr/bin/env sh

command=$1
walletName=$2
password=$(cat -) # will block until input from stdin

if [ "$command" = "" ]; then
    command="mix"
fi

if [ "$command" = "mix" ]; then
  /app/checkWalletPassword.sh $walletName $password

  if [ $? = 0 ]; then
    exec /app/startWasabiWalletWithPassword.sh $walletName $password
  else
    echo "Wrong password"
  fi
elif [ "$command" = "check" ]; then
  exec /app/checkWalletPassword.sh $walletName $password
elif [ "$command" = "create" ]; then
  exec /app/generateWallet.sh $walletName $password
else
  echo "Unknown command"
fi

