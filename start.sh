#!/usr/bin/env sh
tor &
dotnet WalletWasabi.Gui.dll mix --wallet:testWallet --mixall --keepalive