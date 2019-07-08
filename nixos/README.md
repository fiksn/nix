# NixOS stuff

## Intro

My NixOS configuration repository

## Install

* Clone repo:

```git clone git@github.com:fiksn/nix.git```

* Place symlink:

```ln -s nix/nixos /etc/nixos ; ln -s nix/nixos/nixpkgs ~/config/.nixpkgs/```

## How to test

```sudo nixos-rebuild test```


