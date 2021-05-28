#!/bin/bash

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

	if [[ ! -d "$HOME"/.themes ]]; then mkdir -p "$HOME"/.themes; fi
	cp -R themes/* "$HOME"/.themes

	cp .zshrc .bashrc .profile .p10k.zsh "$HOME"
	chmod +x "$HOME"/scripts/*
}

postInstall() {
	scripts/setbg "$HOME"/Pictures/Wallpapers/default
	fc-cache -f
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

	echo "Install the MaterialFox theme by muckSponge and smooth scrolling config for Firefox?"
	echo "Note: This will overwrite the Firefox \"user.js\" and \"chrome\" directory files."
	printf "Proceed? (y/N) "
	read res
	if [[ "$res" == "y" ]]; then
		echo "Installing Firefox configuration..."
		firefoxConfig
	fi

	echo "Installed dotfiles. Run \`setbg <path to image>\` to change your desktop background."
	echo "You may now use a tool such as lxappearance to customise GTK and other theming options"
}

echo "Make sure that you have read the readme and installed the required dependencies."
echo "This will overwrite various configuration files. Don't proceed if you have any configurations that you have not backed up."
printf "Proceed? (y/N) "
read res
if [[ "$res" == "y" ]]; then
	run
else
	echo "No changes made. Exiting..."
	exit 0
fi
