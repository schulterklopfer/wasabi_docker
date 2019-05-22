#!/bin/bash

#curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"listunspentcoins"}' http://127.0.0.1:18099/ | jq
#curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"send", "params": { "sendto": "tb1qjlls57n6kgrc6du7yx4da9utdsdaewjg339ang", "coins":[{"transactionid":"8c5ef6e0f10c68dacd548bbbcd9115b322891e27f741eb42c83ed982861ee121", "index":0}], "amount": 15000, "label": "test transaction", "feeTarget":2 }}' http://127.0.0.1:18099/

#curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getnewaddress","params":["payment order #178670"]}' http://127.0.0.1:18099/ | jq

curl -s --data-binary '{"jsonrpc":"2.0","id":"1","method":"getstatus"}' http://127.0.0.1:18099/ | jq