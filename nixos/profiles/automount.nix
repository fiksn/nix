{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.automount;
in
{
  options.profiles.automount.enable = lib.mkEnableOption "Whether to enable USB automounting";

  config = mkIf cfg.enable {
    services.udev = {
      extraRules = ''
        ACTION=="add",KERNEL=="sda*", RUN+="${pkgs.pmount}/bin/pmount --sync --umask 000 %k"
        ACTION=="remove", KERNEL=="sda*", RUN+="${pkgs.pmount}/bin/pumount %k"
        ACTION=="add",KERNEL=="sdb*", RUN+="${pkgs.pmount}/bin/pmount --sync --umask 000 %k"
        ACTION=="remove", KERNEL=="sdb*", RUN+="${pkgs.pmount}/bin/pumount %k"
        ACTION=="add",KERNEL=="sdc*", RUN+="${pkgs.pmount}/bin/pmount --sync --umask 000 %k"
        ACTION=="remove", KERNEL=="sdc*", RUN+="${pkgs.pmount}/bin/pumount %k"
      '';
    };   
	
    environment.systemPackages = with pkgs; [ pmount ];
  };
}
