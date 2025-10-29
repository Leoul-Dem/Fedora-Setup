#!/bin/bash

sudo dnf update -y

echo "Enter Git Name: "
read name
echo "Enter Git Email: "
read email

# snap install
sudo dnf install -y snapd
sudo mkdir -p /snap
sudo ln -s /var/lib/snapd/snap /snap

# setup flatpak
sudo dnf install -y flatpak
sudo dnf install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# btop install and config
sudo dnf install -y btop
mkdir -p ~/.config/btop/themes
cp ./configs/btop.conf ~/.config/btop/btop.conf
cp ./themes/tokyo-night/btop.theme ~/.config/btop/themes/tokyo-night.theme

# fastfetch install and config
sudo dnf install -y fastfetch
mkdir -p ~/.config/fastfetch
cp ./configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc

# github-cli install
sudo dnf install -y dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh --repo gh-cli

# lazygit setup
cd /tmp
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
mkdir -p ~/.config/lazygit/
touch ~/.config/lazygit/config.yml
cd -

# terminal apps
sudo dnf install -y fzf ripgrep bat zoxide fd-find

# zellij install and config
cd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij.tar.gz zellij
sudo install zellij /usr/local/bin
rm zellij.tar.gz zellij
cd -

mkdir -p ~/.config/zellij/themes
[ ! -f "$HOME/.config/zellij/config.kdl" ] && cp ./configs/zellij.kdl ~/.config/zellij/config.kdl
cp ./themes/tokyo-night/zellij.kdl ~/.config/zellij/themes/tokyo-night.kdl

# libraries install
sudo dnf install -y \
  @development-tools \
  pkgconf-pkg-config autoconf bison clang rust cargo python3-pip \
  openssl-devel readline-devel zlib-devel libyaml-devel ncurses-devel libffi-devel gdbm-devel jemalloc jemalloc-devel \
  vips vips-devel ImageMagick ImageMagick-devel mupdf mupdf-libs

# mise install
curl https://mise.run | sh
~/.local/bin/mise --version

# dev language installs
mise use --global node@lts
mise use --global go@latest
mise use --global python@latest
bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
mise use --global java@latest

# Git config
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global pull.rebase true
git config --global user.name "$name"
git config --global user.email "$email"

# install tldr
pipx install tldr

# install gum
sudo dnf install -y gum

# Configure the bash shell using Omakub defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ./configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ./defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Omakub defaults
cp ./configs/inputrc ~/.inputrc

# alacritty install and config
sudo dnf install -y alacritty
mkdir -p ~/.config/alacritty
cp ./configs/alacritty.toml ~/.config/alacritty/alacritty.toml
cp ./configs/alacritty/shared.toml ~/.config/alacritty/shared.toml
cp ./configs/alacritty/pane.toml ~/.config/alacritty/pane.toml
cp ./configs/alacritty/btop.toml ~/.config/alacritty/btop.toml
cp ./themes/tokyo-night/alacritty.toml ~/.config/alacritty/theme.toml
cp ./configs/alacritty/fonts/CaskaydiaMono.toml ~/.config/alacritty/font.toml
cp ./configs/alacritty/font-size.toml ~/.config/alacritty/font-size.toml

# Migrate config format if needed
alacritty migrate 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/pane.toml 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/btop.toml 2>/dev/null || true

# Make Alacritty the default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e'

# flameshot install
sudo dnf install -y flameshot

# gnome-sushi install
# Gives you previews in the file manager when pressing space
sudo dnf install -y sushi

# gnome-tweaks install
sudo dnf install -y gnome-tweaks

# localsend install
sudo flatpak install -y flathub org.localsend.localsend_app
echo "alias localsend='flatpak run org.localsend.localsend_app'" >> ~/.bashrc
source ~/.bashrc

# obsidian install
sudo flatpak install -y flathub md.obsidian.Obsidian
echo "alias obsidian='flatpak run md.obsidian.Obsidian'" >> ~/.bashrc
source ~/.bashrc

# vlc install
sudo dnf install -y vlc

# wl-clipboard install
sudo dnf install -y wl-clipboard

# xournalpp install
sudo dnf install -y xournalpp

# discord install
sudo flatpak install -y flathub com.discordapp.Discord
echo "alias discord='flatpak run com.discordapp.Discord'" >> ~/.bashrc
source ~/.bashrc

# spotify install
sudo flatpak install -y flathub com.spotify.Client
echo "alias spotify='flatpak run com.spotify.Client'" >> ~/.bashrc
source ~/.bashrc

# zed editor install
curl https://zed.dev/install.sh | sh

# zoom install
sudo flatpak install -y flathub us.zoom.Zoom
echo "alias zoom='flatpak run us.zoom.Zoom'" >> ~/.bashrc
source ~/.bashrc

# zen-browser install
sudo flatpak install -y flathub app.zen_browser.zen
echo "alias zen='flatpak run app.zen_browser.zen'" >> ~/.bashrc
source ~/.bashrc

# the rest of the configs
chmod +x set-app-grid.sh
./set-app-grid.sh
chmod +x extensions.sh
./extensions.sh
chmod +x hotkeys.sh
./hotkeys.sh
chmod +x gnome-settings.sh
./gnome-settings.sh
chmod +x gnome-themes.sh
./gnome-themes.sh
chmod +x set-xcompose.sh
./set-xcompose.sh

# ulauncher install and config
sudo dnf install -y ulauncher
# Start ulauncher to have it populate config before we overwrite
mkdir -p ~/.config/autostart/
cp ./configs/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp ./configs/ulauncher.json ~/.config/ulauncher/settings.json

# Revert to normal idle and lock settings
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.session idle-delay 300

sudo reboot
