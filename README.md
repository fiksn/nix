# Nix related stuff

[![Build Status](https://travis-ci.org/fiksn/nix.svg?branch=master)](https://travis-ci.org/fiksn/nix)

I'm playing around with Nix and recently NixOS, here will be the public part of my configurations and other toy examples on 
my path towards learning Nix.

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

I found using nix as a package manager is the best entry drug to the shiny Nix world.

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

## Motivation

Domen Kožar in his [blog post](https://www.domenkozar.com/2014/03/11/why-puppet-chef-ansible-arent-good-enough-and-we-can-do-better/) can explain
better than me why Nix is the way to go for package management. Nix is a functional programming language avoiding side-effects.

The point is not that is pure or functional but that it easy composable allowing you to untangle a mess of copy-pasted scripts.

## TODO

Testing is currently done like in this suggestion 
https://github.com/NixOS/nixpkgs/issues/25264
and only with nix-instantiate, perhaps we need to change that?

I need to start using [Kubenix](https://github.com/xtruder/kubenix)
