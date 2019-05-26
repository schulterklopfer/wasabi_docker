# wasabi_docker
Proof of concept on how to run Wasabi inside a docker container in daemon mode.

 <span style="color:red">ATTENTION!!!</span> 
 
 This repo will use an experimental version of Wasabi wallet from https://github.com/lontivero/WalletWasabi/tree/Features/Rpc-Server.
 It is not intended to be used in any production environment on mainnet.
 
 <span style="color:red">ATTENTION!!!</span>

Supported archs:
* x86_64

Planned archs (check if possible at all):
* armhf
* aarch64

```bash
# build image
./build.sh

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

# When mix mode is entered you should be able to use
# wasabi's RPC interface to get info about unspent coins,
# your wallet or send funds around.

# try:
# (jq is not needed, but makes the json result more readable)

curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getstatus"}' http://127.0.0.1:18099/ | jq
curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getwalletinfo"}' http://127.0.0.1:18099/ | jq
curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"listunspentcoins"}' http://127.0.0.1:18099/ | jq
curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getnewaddress","params":["payment order #178670"]}' http://127.0.0.1:18099/ | jq

# curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"send", "params": { "sendto": "<address>", "coins":[{"transactionid":"<txid>", "index":<index>}], "amount": <amount>, "label": "<label>", "feeTarget":<feetarget> }}' http://127.0.0.1:18099/

```
