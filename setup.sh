#!/bin/bash

# ------- Config -------
echo "What browser do you want to use? (chrome, firefox, safari)"
read browser
# ------- Config -------

# ------- Xcode -------
echo "Installing xcode-stuff 👨‍💻"
xcode-select --install
# ------- Xcode -------

# ------- Homebrew -------

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew... 🍺"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$user/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update homebrew recipes
echo "Updating homebrew... 🆕"
brew update

brew config

brew install coreutils
brew install nginx
brew install nginx

# Install apps:

brew tap homebrew/completions
brew install homebrew/completions/docker-completion
brew install homebrew/completions/docker-compose-completion

apps=(
  expo-orbit
  bitwarden
  google-chrome
  spotify
  visual-studio-code
  ngrok
  github-desktop
  figma
  slack
  zulu11
  warp
  docker
  alfred
)

echo "Installing apps with Cask... ⏳"
brew install --cask --appdir="/Applications" ${apps[@]}

case $browser in
  chrome)
    brew cask install google-chrome
    ;;
  firefox)
    brew cask install firefox
    ;;
  safari)
    echo "Safari is already installed on your Mac 🍎"
    ;;
  *)
    echo "Invalid browser. Please install it manually."
    ;;
esac

# Remove outdated versions from the cellar.
brew cleanup

# ------- Homebrew -------

# ------- Git -------
echo "Installing Git... 🦸‍♂️"
brew install git

echo "Git config 🙋‍♂️ - Enter your data and press Enter!"


echo -n 'Username: '
read username
git config --global user.name "$username"

echo -n 'Mail: '
read mail
git config --global user.email $mail
# ------- Git -------

# ------- SSH Key for GitHub -------
echo "Creating an SSH key for you... 🔐"
ssh-keygen -t rsa

echo -e "Please add this public key to Github 👻 \n"
cat ~/.ssh/id_rsa.pub
case $browser in
  chrome)
    open -a "Google Chrome" https://github.com/settings/keys
    ;;
  firefox)
    open -a "Firefox" https://github.com/settings/keys
    ;;
  safari)
    open -a "Safari" https://github.com/settings/keys
    ;;
  *)
    echo "Please add the SSH key to GitHub manually."
    ;;
esac
read -p "Press [Enter] key after this... ⌨️"
# ------- SSH Key for GitHub -------

# ------- Terminal Setup -------

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH... 😱"
curl -L http://install.ohmyz.sh | sh

echo "Setting up Oh My Zsh theme... 🎨"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
open ~/.zshrc
read -p "Please set ZSH_THEME=\"powerlevel10k/powerlevel10k\" ✍️ and then press Enter!"

echo "Add some auto suggestions... 👨‍🚒"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
open ~/.zshrc
read -p "Please add zsh-autosuggestions & zsh-syntax-highlighting to your Plugins! e. g. plugins=(... zsh-autosuggestions zsh-syntax-highlighting) (WITHOUT comma) ✍️ and then press Enter!"
 
echo "Setting ZSH as shell... 💻"
chsh -s /usr/local/bin/zshd

# ------- Terminal Setup -------

