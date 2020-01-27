#!/bin/sh

set -x

ZONEID=212e54119a66dc835b5138db1929dd46 # Your zone id, hex16 string
RECORDID=01913c532b52c894ab874678ddb0b49d # You DNS record ID, hex16 string
RECORDNAME=blowtorch.xyz # Your DNS record name, e.g. sub.example.com
API=ccd9ce6cff57c2cdb2a5c302f1aa7816a1bb5 # Cloudflare API Key
IP=`curl --silent https://api.ipify.org`

curl -X PUT "https://api.cloudflare.com/client/v4/zones/212e54119a66dc835b5138db1929dd46/dns_records/01913c532b52c894ab874678ddb0b49d" \
    -H "X-Auth-Email: pheistman@live.co.uk" \
    -H "X-Auth-Key: ccd9ce6cff57c2cdb2a5c302f1aa7816a1bb5" \
    -H "Content-Type: application/json" \
     --data '{"type":"A","name":"blowtorch.xyz","content":"'`curl --silent https://api.ipify.org`'","ttl":120,"proxied":false}'

#where 0 = failure, 1 = successful update
if [ $? -eq 0 ]; then
  /sbin/ddns_custom_updated 1
else
  /sbin/ddns_custom_updated 0
fi
