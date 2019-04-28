# /etc/nixos/kubernetes.nix

{ config, pkgs, ... }:

{
  services.kubernetes.roles = ["master" "node"];
}
