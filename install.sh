#!/bin/bash

pip3 install i3ipc

if [[ ! -d "$HOME"/.config ]]; then mkdir -p "$HOME"/.config; fi
cp -R config/* "$HOME"/.config

if [[ ! -d "$HOME"/scripts ]]; then mkdir -p "$HOME"/scripts; fi
cp -R scripts/* "$HOME"/scripts

if [[ ! -d "$HOME"/Pictures ]]; then mkdir -p "$HOME"/Pictures; fi
cp images/background "$HOME"/Pictures

if [[ ! -d "$HOME"/.local/share/fonts ]]; then mkdir -p "$HOME"/.local/share/fonts; fi
cp -R fonts/* "$HOME"/.local/share/fonts

cp .zshrc .profile "$HOME"
chmod +x "$HOME"/scripts/*
