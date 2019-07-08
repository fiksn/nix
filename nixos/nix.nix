{ config, pkgs, lib, ... }:

with lib;

{
  nix.package = pkgs.nixUnstable;
  nix.useSandbox = true;

  # automatic gc
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "--delete-older-than 30d";
  };
  
  services.nixosManual.showManual = false;
  documentation.man.enable = true;

  # disable the infamous systemd screen/tmux killer
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

}
