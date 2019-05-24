# wasabi_docker
Proof of concept on how to run Wasabi inside a docker container in daemon mode.

ATTENTION: this repo will use an experimental version of Wasabi wallet from https://github.com/lontivero/WalletWasabi/tree/Features/Rpc-Server

Supported archs:
* x86_64

Planned archs (check if possible at all):
* armhf
* aarch64

```bash
# create wallet
# the wallet password is provided through stdin
# will create a wasabi wallet json wallet file inside the 
# client/Wallets folder
echo "test123" | ./wassabee create myWallet

# check wallet password
# the wallet password is provided through stdin
# will exit with 0 when password is ok, ottherwise with 1
echo "test123" | ./wassabee check myWallet

# create wallet
# the wallet password is provided through stdin
# will mix coins in myWallet according to the settings
# in Config.json inside the client folder
echo "test123" | ./wassabee mix myWallet
```