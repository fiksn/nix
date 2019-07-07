# Nix related stuff

[![Build Status](https://travis-ci.org/fiksn/nix.svg?branch=master)](https://travis-ci.org/fiksn/nix)

I'm playing around with Nix and recently NixOS, here will be the public part of my configurations and other toy examples on 
my path towards learning Nix.

## Disclaimer

WARNING: the code here is crap :) Follow it if you want to learn.

## Installing Nix

Can be done as simple as:

```
curl https://nixos.org/nix/install | sh
```

Bootstrap multiuser:
```
curl https://nixos.org/nix/install -o install
sh ./install --daemon
```

## Using Nix as a package manager

I found using [Nix](https://nixos.org/nix/) as a package manager is the best entry drug to the shiny [NixOS](https://nixos.org) world.
It even works on MacOS.

Update channel:
```
nix-channel --update
```

Search and install package:
```
nix-enq -qaP | grep go
nix-env -iA nixpkgs.go
```

Update all packages:
```
nix-enq -u
```

## Getting started

[NixPills](https://nixos.org/nixos/nix-pills/) is a great resource to learn.
As you can see this stuff is also inspired by [Sam's blog post series](https://www.sam.today/blog/environments-with-nix-shell-learning-nix-pt-1/) too.

Useful resources:
* [Useful Nix Hacks](http://chriswarbo.net/projects/nixos/useful_hacks.html)
* [Tyler Slabinski NixOS config](https://gitlab.com/slabity/nixos-config)
* [Functional DevOps in a Dysfunctional World](https://vaibhavsagar.com/blog/2019/07/04/functional-devops/)

## Motivation

Domen Kožar in his [blog post](https://www.domenkozar.com/2014/03/11/why-puppet-chef-ansible-arent-good-enough-and-we-can-do-better/) can explain
better than me why [Nix](https://nixos.org/nix/) is the way to go.

I've been using [Puppet](https://puppet.com) or as I call it the [PHP](https://www.php.net) of configuration management since version 2 :)
It always becomes a tangled mess eventhough I've been trying to follow role/profile/module pattern. A strong functional language has a steep learning curve, but I
believe in the long term the simple composability pays off.

## TODO

Testing is currently done like in this suggestion 
https://github.com/NixOS/nixpkgs/issues/25264
and only with nix-instantiate, perhaps we need to change that?

Try [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/rycee/home-manager)

## CI

GitLab
```
target:
  image: nixos/nix
  variables:
    NIX_PATH: "nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.09.tar.gz"
  script:
    - nix-build ...
```

Travis

```
language: nix
env:
  - NIX_PATH="nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.09.tar.gz"
```
