#!/bin/bash

query="$1"
GIPHY_API_KEY="$2"
random_offset=$((RANDOM % 250 + 1))
gif_url=$(curl -s "https://api.giphy.com/v1/gifs/search?api_key=$GIPHY_API_KEY&q=$query&limit=1&offset=$random_offset&rating=g&lang=en" | jq -r '.data[0].images.fixed_height.url')
echo "$gif_url"
