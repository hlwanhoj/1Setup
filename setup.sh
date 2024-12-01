# Reference:
# https://gist.github.com/bradp/bea76b16d3325f5c47d4
echo "Installing Xcode tools..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Git config"
git config --global user.name "hlwanhoj"
git config --global user.email hlwanhoj@gmail.com

echo "Installing brew formulae..."
brew_apps=(
  asdf
  ffmpeg
  yt-dlp
)
brew install ${brew_apps[@]}

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Apps
apps=(
  arc
  iterm2
  raycast
  fork
  jetbrains-toolbox
  1password
  visual-studio-code
  blender
  obsidian
  vlc
  copilot-for-xcode
  stats
  parsec
  obs
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Homebrew Cask..."
brew install --cask ${apps[@]}

echo "Cleaning up brew..."
brew cleanup

killall Finder

echo "Done!"

#@TODO install vagrant and sites folder