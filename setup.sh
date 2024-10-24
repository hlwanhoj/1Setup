#!/bin/bash

dry_run=false

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install a command if it is not already installed
# Arguments:
#   $1 - Command to check if it exists
#   $2 - Name of the command to install
#   $3 - Installation command to run if the command is not found
_install_command() {
  if eval "$1" "$2"; then
    echo "$2 is installed."
  else
    echo "Installing $2..."
    if $dry_run; then
      echo "$3"
    else
      $3
    fi
  fi
}

install_command() {
  _install_command command_exists "$1" "$2"
}

brew_install() {
  _install_command "brew list" "$1" "brew install $1"
}

brew_install_cask() {
  _install_command "brew list" "$1" "brew install --cask $1"
}

run_and_wait() {
  eval "$2"
  IFS= read -p "When you complete the installation of $1, come back here and press Enter." -r
}

download_apple_transporter() {
  output=$(curl --output-dir "$HOME/Downloads" -w "%{filename_effective}" -svfJLO "https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/resources/download/public/Transporter__OSX/bin/")
  run_and_wait "Apple's Transporter" "open $output"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)
            dry_run=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done


install_command "brew" "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
brew_install "asdf"
brew_install "ffmpeg"
brew_install "yt-dlp"
run_and_wait 'Arc' "open https://arc.net/"
run_and_wait 'Xcode' "open https://developer.apple.com/download/all/?q=Xcode"
download_apple_transporter
run_and_wait 'Visual Studio Code' "open https://code.visualstudio.com/"
run_and_wait 'JetBrains Toolbox App' "open https://www.jetbrains.com/toolbox-app/"
run_and_wait 'Proxyman' "open https://proxyman.io/"
run_and_wait 'Obsidian' "open https://obsidian.md/"
brew_install_cask "stats"
brew_install_cask "copilot-for-xcode"