# /etc/nixos/configuration.nix

{ ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./configuration-common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
}
