#!/bin/bash

# Extract the token from the query string passed as a parameter
TOKEN=$(echo "$1" | sed -n 's/.*token=\([^&]*\).*/\1/p')

# Check if the token is empty
if [ -z "$TOKEN" ]; then
  echo "No token provided!"
  exit 1
fi

# Install Python and pip
echo "Installing Python and pip..."
sudo apt update && sudo apt install -y python3 python3-pip || { echo "Failed to install Python or pip"; exit 1; }

# Install discord.py
echo "Installing discord.py..."
pip3 install discord.py || { echo "Failed to install discord.py"; exit 1; }

# Create the bot script with the token
cat > bot.py <<EOF
import discord

TOKEN = "$TOKEN"

class MyClient(discord.Client):
    async def on_ready(self):
        print(f"Logged in as {self.user}")
        print(f"WebSocket Latency: {self.latency * 1000:.2f}ms")

client = MyClient(intents=discord.Intents.default())
client.run(TOKEN)
EOF

# Run the bot
echo "Running the bot..."
python3 bot.py
