### Dotfiles for Arch Linux

## Screenshots

![Primary](images/screenshot-1.png)

![Secondary](images/screenshot-2.png)

## Details

**OS** GNU/Linux

**Distro** Arch Linux

**WM** i3-gaps

**Compositor** picom-ibhagwan

**Bar** polybar, original theme by adi1090x (modified)

**Launcher** rofi

**Terminal Emulators** alacritty, kitty

**Shell** zsh

**Shell Theme** grml-zsh-config, powerlevel10k

**AUR Helper** pikaur

**Text Editors** micro, vim, code

**Monospace Fonts** GohuFont, MesloLGS NF, Droid Sans Mono

**UI Fonts** Droid Sans 11pt

**Browser** firefox

**Browser Theme** MaterialFox

**GTK Theme** ChromeOS-light-compact

**Icon Theme** Papirus

**Cursor Theme** McMojave Cursors

**Music Player** mpd + ncmpcpp

## Installation

All packages are listed assuming use of the main Arch Linux repos and Arch User Repository (AUR)

**Dependencies**

`bash i3-gaps rofi picom-ibhagwan-git polybar-git feh`

**Recommended packages**

`pikaur zsh autotiling alacritty kitty ttf-droid grml-zsh-config lxappearance firefox vim micro xorg-xset xss-lock i3lock-color-git redshift zsh-theme-powerlevel10k-git`

**Other packages, including programs and tools used**

`lxpolkit libinput-gestures xorg-xrandr code mpd mpc ncmpcpp pulseaudio network-manager`

Keeping in mind that configurations will be overwritten, run `./install.sh` to install the configuration files.
