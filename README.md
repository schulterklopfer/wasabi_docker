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

Edit .env to fit your configuration

```bash
# build image
./build.sh
# Create docker-compose.yaml file with 10 wasabi mixers
./init.sh 10

# start everything
docker-compose up -d

# test rpc

./test_rpc.sh

# try:
# (jq is not needed, but makes the json result more readable)

# execInWasabi.sh <instanceId> <command>

./execInWasabi.sh 1 curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getstatus"}' http://127.0.0.1:18099/ | jq
./execInWasabi.sh 1 curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getwalletinfo"}' http://127.0.0.1:18099/ | jq
./execInWasabi.sh 1 curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"listunspentcoins"}' http://127.0.0.1:18099/ | jq
./execInWasabi.sh 1 curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getnewaddress","params":["payment order #178670"]}' http://127.0.0.1:18099/ | jq

# ./execInWasabi.sh 1 curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"send", "params": { "sendto": "<address>", "coins":[{"transactionid":"<txid>", "index":<index>}], "amount": <amount>, "label": "<label>", "feeTarget":<feetarget> }}' http://127.0.0.1:18099/

```
