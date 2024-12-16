#!/bin/bash

# 定义一个数组，包含所有的 recipient 地址
recipients=(
    "0xfffee58fd4622957d1f4d2582ba3b2d36d43ab89029f10e352ac2974c561b5f9"
    "0xe36cf5f9baeef2c989088d8879e850f02e91e1cb48d53acf1ec5f44223370e84"
    "0x237a4728defca6bb0c2a4ccc643e71c4ea04c361c3f3c76a164401e2fa700dd8"
)


for recipient in "${recipients[@]}"; do
    response=$(curl --write-out "%{http_code}" --silent --output /dev/null --location --request POST 'https://faucet.testnet.sui.io/gas' \
    --header 'Content-Type: application/json' \
    --data-raw "{
        \"FixedAmountRequest\": {
            \"recipient\": \"$recipient\"
        }
    }")

    if [ "$response" -ne 200 ]; then
        echo "Failed to send gas to $recipient. HTTP status code: $response"
    else
        echo "Successfully sent gas to $recipient"
    fi

    sleep 10
done

