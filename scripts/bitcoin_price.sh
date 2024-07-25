#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

get_coinbase_bitcoin_price() {
    curl -s https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT | jq -r '.price'
}

format_price() {
awk -v price="$1" 'BEGIN { printf "%'"'"'2.2f\n", price }'
}

main() {
bitcoin_raw_price=$(get_coinbase_bitcoin_price)
rounded_bitcoin_price=$(format_price $bitcoin_raw_price)
echo "$rounded_bitcoin_price USDT "
}

main "$@"
