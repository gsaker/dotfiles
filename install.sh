#!/bin/bash

desktoptheme="https://github.com/vinceliuice/ChromeOS-theme"
materialfox="https://github.com/muckSponge/MaterialFox"

copy() {
	if [[ ! -d "$HOME"/.config ]]; then mkdir -p "$HOME"/.config; fi
	cp -R config/* "$HOME"/.config
	
	if [[ ! -d "$HOME"/scripts ]]; then mkdir -p "$HOME"/scripts; fi
	cp -R scripts/* "$HOME"/scripts
	
	if [[ ! -d "$HOME"/Pictures ]]; then mkdir -p "$HOME"/Pictures; fi
	cp -R images/Wallpapers "$HOME"/Pictures
	
	if [[ ! -d "$HOME"/.local/share/fonts ]]; then mkdir -p "$HOME"/.local/share/fonts; fi
	cp -R fonts/* "$HOME"/.local/share/fonts

	cp .zshrc .bashrc .profile .p10k.zsh "$HOME"
	chmod +x "$HOME"/scripts/*
}

postInstall() {
	scripts/setbg "$HOME"/Pictures/Wallpapers/default
	fc-cache -f
}

installThemes() {
	root_dir=$(pwd)
	
	git clone "$desktoptheme" ./desktop-theme
	if [[ -d ./desktop-theme ]]; then
		cd ./desktop-theme
		./install.sh
		
		cd "$root_dir"
		rm -rf ./desktop-theme
	fi

	if [[ ! -d "$HOME"/.themes ]]; then mkdir -p "$HOME"/.themes; fi
	cp -R themes/* "$HOME"/.themes
}

firefoxConfig() {
	ff="$HOME"/.mozilla/firefox
	if [[ -d "$ff" ]]; then
		root_dir=$(pwd)
		ff_root=$(ls "$HOME"/.mozilla/firefox)

		cd "$ff"
		profiles=$(find ./ -type d -name "*.default-release")
		
		if [[ -n $profiles ]]; then
			for profile in $profiles; do
				cp "$root_dir"/firefox/user.js "./$profile"
			done
			
			if [[ -d ./materialfox  ]]; then
				echo "Using existing MaterialFox clone"
			else
				git clone "$materialfox" ./materialfox
			fi
			
			if [[ -d ./materialfox/chrome ]]; then
				for profile in $profiles; do
					cp -R ./materialfox/chrome "./$profile"
				done
			else
				echo "Skipping MaterialFox installation"
			fi
		else
			echo "No suitable Firefox profiles found."
		fi

		cd "$root_dir"
	else
		echo "Firefox config directory \"$ff\" not found."
	fi
}

run() {
	echo "Installing; this may take some time..."

	copy
	postInstall

	printf "\nWould you like to install the desktop themes (GTK+, etc.)?\n"
	echo "This requires the GTK Murrine engine for your distro (gtk-engine-murrine for Arch)."
	printf "Proceed? (y/N) "
	read res
	if [[ "$res" == "y" ]]; then
		echo "Installing desktop themes..."
		installThemes
	fi

	printf "\nInstall the MaterialFox theme by muckSponge and smooth scrolling config for Firefox?\n"
	echo "Note: This will overwrite the Firefox \"user.js\" and \"chrome\" directory files."
	printf "Proceed? (y/N) "
	read res
	if [[ "$res" == "y" ]]; then
		echo "Installing Firefox configuration..."
		firefoxConfig
	fi

	printf "\nInstalled dotfiles. Run \`setbg <path to image>\` to change your desktop background.\n"
	echo "You may now use a tool such as lxappearance to customise GTK and other theming options"
}

echo "Make sure that you have read the readme and installed the required dependencies. This script should only be run from the repository root."
echo "This will also overwrite various configuration files, so please don't proceed if you have any configurations that you have not backed up."
printf "Proceed? (y/N) "
read res
if [[ "$res" == "y" ]]; then
	run
else
	echo "No changes made. Exiting..."
	exit 0
fi
