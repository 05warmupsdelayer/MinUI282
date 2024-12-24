#!/bin/bash

# Function to show Git commit details
show() {
    if [ -d "$1" ]; then
        pushd "$1" >> /dev/null
        HASH=$(git rev-parse --short=8 HEAD)
        NAME=$(basename $PWD)
        DATE=$(git log -1 --pretty='%ad' --date=format:'%Y-%m-%d')
        REPO=$(git config --get remote.origin.url)
        REPO=$(sed -E "s,(^git@github.com:)|(^https?://github.com/)|(.git$)|(/$),,g" <<<"$REPO")
        popd >> /dev/null
        printf '%-40s%-15s%-15s%-15s\n' $NAME $HASH $DATE $REPO
    elif [ -f "$1" ]; then
        # Handle files (for CORES section)
        FILE_HASH=$(sha256sum "$1" | awk '{ print $1 }' | cut -c1-8)  # Compute sha256 hash for the file
        NAME=$(basename "$1")  # Get the file name
        DATE=$(date -r "$1" "+%Y-%m-%d")  # Get the modified date of the file
        printf '%-40s%-15s%-15s%-15s\n' "$NAME" "$FILE_HASH" "$DATE" "zoltanvb.github.io/armv7-hf-neon"
    fi
}

# List function to display all contents in a directory
list() {
    pushd "$1" >> /dev/null
    for D in ./*; do
        show "$D"
    done
    popd >> /dev/null
}

# Rule to print separator line
rule() {
    echo '------------------------------------------------------------------------------------------------------'
}

# Tell function to print section header
tell() {
    echo $1
    rule
}

# CORES handler function
cores() {
    list ./workspace/$1/cores/output  # List all files in the cores output directory
    bump
}

# Bump to print a new line
bump() {
    printf '\n'
}

# Main block to print information about the repositories and cores
{
    # MINUI Section
    printf '%-40s%-15s%-15s%-15s\n' MINUI HASH DATE USER/REPO
    rule
    show ./
    bump
    
    # TOOLCHAINS Section
    tell "TOOLCHAINS"
    list ./toolchains
    bump
    
    # LIBRETRO Section
    tell "LIBRETRO"
    show ./workspace/all/minarch/libretro-common
    bump
    
    # MY282 Section
    tell "MY282"
    show ./workspace/my282/other/unzip60
    bump
    
    # CORES Section
    tell "CORES"
    cores my282  # Specify the correct directory for CORES
    bump

} | sed 's/\n/ /g'
