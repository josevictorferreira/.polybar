#!/bin/bash

# MUST DECLARE THE FOLLOWING VARIABLES IN THE bank_secrets.sh FILE:
# BASE_URL, CLIENT_ID, CLIENT_SECRET
# PUT THE CLIENT.CRT AND CLIENT.KEY INSIDE THE SCRIPTS FOLDER

source "$HOME/.config/polybar/scripts/bank_secrets.sh"

CRT_FILE_PATH="$HOME/.config/polybar/scripts/client.crt"
KEY_FILE_PATH="$HOME/.config/polybar/scripts/client.key"

is_internet_connected () {
  interface=$(ifconfig enp4s0 | grep inet)
  if [[ $interface == "" ]]; then
    echo 0
  else
    echo 1
  fi
}

get_token () {
  curl -s -X POST "$BASE_URL/oauth/v2/token" -H "Content-Type: application/x-www-form-urlencoded" --cert "$CRT_FILE_PATH" --key "$KEY_FILE_PATH" --data "client_id=$CLIENT_ID" --data "client_secret=$CLIENT_SECRET" --data "grant_type=client_credentials" --data "scope=extrato.read" | jq -r '.access_token'
}

get_account_balance () {
  token="$1"
  balance=$(curl -s "$BASE_URL/banking/v2/saldo" -H "Authorization: Bearer $token" --cert "$CRT_FILE_PATH" --key "$KEY_FILE_PATH" | jq -r '.disponivel')
  echo "R$ $balance"
}

main () {
  while [ "$(is_internet_connected)" == "0" ]; do sleep 5; done
  token=$(get_token)
  get_account_balance "$token"
}

main "$@"
