#!/bin/bash
#Download built cores from https://github.com/zoltanvb/retroarch-cross-compile
# Base URL
BASE_URL="https://zoltanvb.github.io/armv7-hf-neon/"

# Selected cores
FILES=(
  "fceumm_libretro.so.zip"
  "gambatte_libretro.so.zip"
  "gpsp_libretro.so.zip"
  "pcsx_rearmed_libretro.so.zip"
  "picodrive_libretro.so.zip"
  "snes9x2005_plus_libretro.so.zip"
  "mednafen_pce_fast_libretro.so.zip"
  "mednafen_vb_libretro.so.zip"
  "fake-08_libretro.so.zip"
  "mednafen_supafaust_libretro.so.zip"
  "mgba_libretro.so.zip"
  "pokemini_libretro.so.zip"
  "race_libretro.so.zip"
)

# Directories
DL_DIR="./dl"
OUTPUT_DIR="./output"

# Ensure directories exist
mkdir -p "$DL_DIR" "$OUTPUT_DIR"

# Download, extract, and clean up
for FILE in "${FILES[@]}"; do
  wget -P "$DL_DIR" "${BASE_URL}${FILE}"
  unzip -o "$DL_DIR/$FILE" -d "$OUTPUT_DIR"
  rm "$DL_DIR/$FILE" && rmdir $DL_DIR
done
