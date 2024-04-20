#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi

cd "$(dirname "")"

get_dollar_price_in_brazilian_reais() {
	curl -s https://economia.awesomeapi.com.br/all/USD-BRL | jq -r '.USD.ask'
}

format_price() {
	awk -v price="$1" 'BEGIN { printf "%'"'"'2.2f\n", price }'
}

main() {
  dollar_raw_price=$(get_dollar_price_in_brazilian_reais)
  rounded_dollar_price=$(format_price $dollar_raw_price)
  echo " USD: $rounded_dollar_price BRL "
}

main "$@"
