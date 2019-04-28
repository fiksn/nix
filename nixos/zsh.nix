# /etc/nixos/zsh.nix

{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  environment.systemPackages = with pkgs; [ zsh zsh-git-prompt oh-my-zsh ];
  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];
}
