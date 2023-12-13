#!/usr/bin/env bash
#
# Copyright © 2023 Kizziama <kizziama@proton.me>
#

set -e

msg() {
  echo -e "\e[1;32m$1\e[0m"
}

msg "[#] Installing required packages!"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
    adb android-sdk-platform-tools autoconf automake axel bc binutils bison \
    build-essential ccache clang cmake coreutils curl expat fastboot flex g++ \
    g++-multilib gawk gcc gcc-multilib git git-lfs gnupg gperf \
    htop imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev \
    libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev \
    libsdl1.2-dev libssl-dev libtool libxml2 libxml2-utils lld llvm '^lzma.*' lzop \
    maven ncftp ncurses-dev patch patchelf pkg-config pngcrush \
    pngquant python2.7 python-all-dev re2c schedtool squashfs-tools subversion \
    texinfo unzip w3m xsltproc zip zlib1g-dev lzip \
    libxml-simple-perl libswitch-perl apt-utils \
    libncurses5 python-is-python3 ssh sudo openssl wget \
    rclone rsync aria2 ffmpeg lsb-release tar apt-transport-https pigz \
    autogen autotools-dev binutils-aarch64-linux-gnu binutils-arm-linux-gnueabi \
    brotli bzip2 ca-certificates cpio expect help2man jq libelf-dev libgomp1-* \
    liblz4-tool libstdc++6 libtool-bin m4 make nano openjdk-17-jdk openssh-client \
    ovmf shtool sshpass u-boot-tools xz-utils zstd tmate locales default-jdk apktool \
    libarchive-tools zram-tools kmod
msg "[✓] Install required packages successfully!"

msg "[#] Setup a locales!"
sudo locale
sudo locale-gen "C.UTF-8"
sudo dpkg-reconfigure locales
msg "[✓] Done!"

msg "[#] Install Github CLI!"
sudo curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install -y gh
msg "[✓] Done!"

msg "[#] Install Repo!"
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo
msg "[✓] Done!"

msg "[#] Configure udev rules for ADB!"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
msg "[✓] Done!"

msg "[#] Installing Android SDK platform tools!"
wget -q https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip -qq platform-tools-latest-linux.zip
rm platform-tools-latest-linux.zip
msg "[✓] Done!"

msg "[#] Installing apktool and JADX!"
mkdir -p bin
wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.6.0.jar -O bin/apktool.jar
echo 'alias apktool="java -jar $HOME/bin/apktool.jar"' >>.bashrc

wget -q https://github.com/skylot/jadx/releases/download/v1.4.4/jadx-1.4.4.zip
unzip -qq jadx-1.4.4.zip -d jadx
rm jadx-1.4.4.zip
echo 'export PATH="$HOME/jadx/bin:$PATH"' >>.bashrc
msg "[✓] Done!"
