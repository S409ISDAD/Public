#!/bin/bash

# Install Python and pip
echo "Installing Python and pip..."
sudo apt update && sudo apt install -y python3 python3-pip || { echo "Failed to install Python or pip"; exit 1; }

# Install discord.py
echo "Installing discord.py..."
pip3 install discord.py || { echo "Failed to install discord.py"; exit 1; }

# Ask for the bot token
read -p "Enter your Discord bot token: " BOT_TOKEN

# Create the bot script
cat > bot.py <<EOF
import discord

TOKEN = "$BOT_TOKEN"

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
