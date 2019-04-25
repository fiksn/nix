#!/bin/sh

sudo cp -fr ./*.nix /etc/nixos/ 
sudo cp -fr ./config /etc/nixos/config

sudo nixos-rebuild test
