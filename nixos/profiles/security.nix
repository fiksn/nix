{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.security;
in
{
  options.profiles.security.enable = lib.mkEnableOption "Whether to enable security";
  config = mkIf cfg.enable {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    #security.hideProcessInformation = true;
    boot.cleanTmpDir = true;
  };
}
