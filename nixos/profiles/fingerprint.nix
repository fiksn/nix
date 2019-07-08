{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.fingerprint;
in
{
  options.profiles.fingerprint.enable = lib.mkEnableOption "Whether to enable fingerprint reader";
  config = mkIf cfg.enable {
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;
    security.pam.services.xscreensaver.fprintAuth = true;
  };
}
