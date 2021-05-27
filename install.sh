#!/bin/bash

copy() {
	echo "Installing; this may take some time..."

	if [[ ! -d "$HOME"/.config ]]; then mkdir -p "$HOME"/.config; fi
	cp -R config/* "$HOME"/.config
	
	if [[ ! -d "$HOME"/scripts ]]; then mkdir -p "$HOME"/scripts; fi
	cp -R scripts/* "$HOME"/scripts
	
	if [[ ! -d "$HOME"/Pictures ]]; then mkdir -p "$HOME"/Pictures; fi
	cp -R images/Wallpapers "$HOME"/Pictures
	
	if [[ ! -d "$HOME"/.local/share/fonts ]]; then mkdir -p "$HOME"/.local/share/fonts; fi
	cp -R fonts/* "$HOME"/.local/share/fonts

	if [[ ! -d "$HOME"/.themes ]]; then mkdir -p "$HOME"/.themes; fi
	cp -R themes/* "$HOME"/.themes
	
	cp .zshrc .bashrc .profile .p10k.zsh "$HOME"
	chmod +x "$HOME"/scripts/*
	scripts/setbg "$HOME"/Pictures/Wallpapers/default
	fc-cache -f

	echo "Installed. Run \`setbg <path to image>\` to change your desktop background."
	echo "You may now use a tool such as lxappearance to customise GTK and other theming options"
}

echo "Make sure that you have read the readme and installed the required dependencies."
echo "This will overwrite certain files and therefore data loss may occur when installing this configuration."
printf "Proceed? (y/N) "
read res
if [[ "$res" == "y" ]]; then
	copy
else
	echo "No changes made. Exiting..."
	exit 0
fi
