#!/bin/sh

sudo cp -fr ./*.nix /etc/nixos/ 
sudo mkdir -p /etc/nixos/profiles
sudo cp -fr ./profiles/* /etc/nixos/profiles

sudo nixos-rebuild test
