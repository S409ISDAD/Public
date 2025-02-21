#!/bin/bash

# Prompt the user to enter the bot token
read -p "Please enter your bot token: " TOKEN

# Install Python and pip (if not already installed)
echo "Installing Python and pip..."
sudo apt update && sudo apt install -y python3 python3-pip python3-venv || { echo "Failed to install Python or pip"; exit 1; }

# Create a virtual environment
python3 -m venv discord_bot_env

# Activate the virtual environment
source discord_bot_env/bin/activate

# Install discord.py inside the virtual environment
echo "Installing discord.py..."
pip install discord.py || { echo "Failed to install discord.py"; exit 1; }

# Create the bot script with the entered token
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
python bot.py
