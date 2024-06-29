#!/bin/bash

# Buat direktori .fonts jika belum ada
mkdir -p ~/.fonts

# URL untuk mengunduh UbuntuMono Nerd Font dari Nerd Fonts repository
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip"

# Nama file zip yang akan diunduh
ZIP_FILE="UbuntuMono.zip"

# Unduh font menggunakan curl
curl -L $FONT_URL -o $ZIP_FILE

# Ekstrak file zip ke direktori .fonts
unzip $ZIP_FILE -d ~/.fonts

# Hapus file zip setelah diekstrak
rm $ZIP_FILE

# Refresh cache font
fc-cache -fv

echo "UbuntuMono Nerd Font installed successfully in ~/.fonts directory."
