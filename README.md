# Kivy Android App

```sh
sudo apt update
sudo apt install -y python3-pip git
pip install buildozer
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev

sudo apt install -y \
build-essential \
libssl-dev \
libffi-dev \
python3-dev \
openjdk-17-jdk \
unzip \
zlib1g-dev

sudo apt install -y autoconf automake libtool

sudo apt install -y \
autoconf \
automake \
libtool \
pkg-config \
build-essential \
cmake \
git \
openjdk-17-jdk \
unzip \
zlib1g-dev \
libncurses5-dev \
libncursesw5-dev \
libtinfo6
```

p4a apk \
--private . \
--package=org.example.myapp \
--name "My application" \
--version 0.1 \
--bootstrap=sdl2 \
--requirements=python3,kivy \
--arch=arm64-v8a \
--arch=armeabi-v7a

export NDKAPI="21"  # Minimum supported API version of your application
export ANDROIDNDKVER="r10e"  # Version of the NDK you installed
export ANDROIDAPI=31
export ANDROIDNDK=$HOME/Android/Sdk/ndk/25.2.9519653
export ANDROIDSDK=$HOME/Android/Sdk

https://chatgpt.com/share/69f9c40f-c89c-8332-91ad-a4baf77d8836
