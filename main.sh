#!/bin/sh
set -e

qbt_username="${QBT_USERNAME:-admin}"
qbt_password="${QBT_PASSWORD:-adminadmin}"
qbt_addr="${QBT_ADDR:-http://localhost:8080}" # ex. http://10.0.1.48:8080
url_list="${URL_LIST:-https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt}" # space separated list

# Loop through each URL
for url in $url_list; do
  echo "Fetching content from: $url"

  list_trackers=$(curl -s "$url")

  all_trackers="${all_trackers}${list_trackers}\n"
done

# Make unique
all_trackers=$(echo -e "$all_trackers" | sort -u)

echo "Logging in to qbittorrent at $qbt_addr"

curl --fail --silent --show-error --cookie-jar /tmp/cookies.txt --cookie /tmp/cookies.txt --header "Referer: $qbt_addr" --data "username=$qbt_username" --data "password=$qbt_password" $qbt_addr/api/v2/auth/login 1> /dev/null

echo "Updating trackers list"

json_string=$(jq -n --arg trackers "$all_trackers" '{add_trackers: $trackers}')

curl --fail --silent --show-error --cookie-jar /tmp/cookies.txt --cookie /tmp/cookies.txt --data-urlencode "json=$json_string"  $qbt_addr/api/v2/app/setPreferences

echo "Successfully updated trackers list"
