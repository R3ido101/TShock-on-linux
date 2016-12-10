FROM ubuntu:14.04.4

MAINTAINER Ryan Sheehan <rsheehan@gmail.com>

# Add mono repository
# Update and install mono and a zip utility
# fix for favorites.json error
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list && \
    apt-get update && apt-get install -y \
    zip \
    mono-complete && \
    apt-get clean && \
    favorites_path="/root/My Games/Terraria" && mkdir -p "$favorites_path" && echo "{}" > "$favorites_path/favorites.json"

# EXPOSED PORTS

EXPOSE 7777

ADD https://github.com/NyxStudios/TShock/releases/download/mintaka-pre1-4.3.21-1.26-2.0.0.9/tshock_mintaka_prere_1.zip /
RUN unzip tshock_mintaka_prere_1.zip -d /tshock && \
    rm tshock_mintaka_prere_1.zip && \
    chmod 777 /tshock/TerrariaServer.exe

# Allow for external data
VOLUME ["/world", "/tshock/ServerPlugins"]

# Set working directory to server
WORKDIR /tshock
