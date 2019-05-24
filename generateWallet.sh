#!/usr/bin/env sh
echo Trying to genetate a wallet $1
echo -n "$2" | dotnet WalletGenerator.dll generate --wallet:${1}