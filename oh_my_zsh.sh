#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install Zsh if not installed
echo "Installing Zsh..."
sudo apt install zsh -y

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change the default shell to Zsh (ensure the script is executed in a new shell)
echo "Changing the default shell to Zsh..."
chsh -s $(which zsh)

# Installation complete
echo "Installation complete! Please log out and log back in to use Zsh."

# The next part should be executed after logging in again

echo "Now let's install essential Zsh plugins and configure your environment..."

# Install plugins (ensure this step is executed after the shell is Zsh)
git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git@github.com:zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone git@github.com:zsh-users/zsh-history-substring-search.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
git clone --depth=1 git@github.com:romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Modify ~/.zshrc to add plugins and theme
echo "Configuring Zsh plugins and theme..."
sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search git-prompt)' ~/.zshrc
sed -i '/^ZSH_THEME=/c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc

# Final message
echo "Plugins and theme installed! Please log out and log back in again for changes to take effect."

