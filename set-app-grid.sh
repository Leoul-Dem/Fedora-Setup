#!/bin/bash

# Remove Btop entry for one that runs in Alacritty
sudo rm -f /usr/share/applications/btop.desktop

# Flameshot app doesn't work as intended from the app grid
sudo rm -f /usr/share/applications/org.flameshot.Flameshot.desktop

# Remove the ImageMagick icon
sudo rm -f /usr/share/applications/display-im6.q16.desktop  # Fedora might not have this; safe to leave

# Replace GNOME System Monitor with Btop in the grid
sudo rm -f /usr/share/applications/org.gnome.gnome-system-monitor.desktop

# Remove custom Neovim/Vim desktop entries
sudo rm -f /usr/local/share/applications/nvim.desktop
sudo rm -f /usr/local/share/applications/vim.desktop

# ------------------------------
# Create GNOME app folders
# ------------------------------

# Set main folder categories
gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'Sundry', 'Updates', 'Xtra', 'LibreOffice', 'WebApps']"

# Configure Updates folder
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Updates/ name 'Install & Update'
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Updates/ apps "['gnome-software.desktop', 'gnome-software-update.desktop', 'fwupd.desktop', 'dnfdragora.desktop']"

# Configure Xtra folder
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Xtra/ name 'Xtra'
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Xtra/ apps "['gnome-language-selector.desktop', 'org.gnome.PowerStats.desktop', 'yelp.desktop', 'org.gnome.eog.desktop']"

# Configure LibreOffice folder
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/LibreOffice/ name 'LibreOffice'
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/LibreOffice/ apps "['libreoffice-base.desktop', 'libreoffice-calc.desktop', 'libreoffice-draw.desktop', 'libreoffice-impress.desktop', 'libreoffice-math.desktop', 'libreoffice-startcenter.desktop', 'libreoffice-writer.desktop', 'libreoffice-xsltfilter.desktop']"

# Configure WebApps folder
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/WebApps/ name 'Web Apps'
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/WebApps/ apps "['basecamp.desktop', 'hey.desktop']"

