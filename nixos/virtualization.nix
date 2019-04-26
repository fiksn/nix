# /etc/nixos/virtualization.nix

{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;  
  environment.systemPackages = with pkgs; [ docker docker_compose ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
