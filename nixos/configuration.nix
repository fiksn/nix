# /etc/nixos/configuration.nix

{ config, pkgs, callPackage, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./configuration-common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  system.stateVersion = "19.03";
}
