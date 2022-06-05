{ config, pkgs, lib, ... }:

with lib;

{
  nix.useSandbox = true;

  # automatic gc
  nix.gc = {
    automatic = false;
    dates = "03:15";
    options = "--delete-older-than 30d";
  };
  
  # disable the infamous systemd screen/tmux killer
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

}
