#! /bin/sh -eu

# nix.extraOptions = "keep-outputs = true";
# Or add ~/.config/nix/nix.conf with keep-outputs = true
mkdir -p .gcroots

# add shell as gc-root in /nix/var/nix/gcroots/auto
nix-instantiate default.nix --indirect --add-root $PWD/.gcroots/shell.drv

exec nix-shell $(readlink $PWD/.gcroots/shell.drv) "$@"
