#!/bin/bash

pip3 install i3ipc

if [[ ! -d "$HOME"/.config ]]; then mkdir "$HOME"/.config; fi
cp -R config/* "$HOME"/.config

if [[ ! -d "$HOME"/scripts ]]; then mkdir "$HOME"/scripts; fi
cp -R scripts/* "$HOME"/scripts

if [[ ! -d "$HOME"/Pictures ]]; then mkdir "$HOME"/Pictures; fi
cp images/background "$HOME"/Pictures

cp .zshrc .profile "$HOME"
chmod +x "$HOME"/scripts/*
