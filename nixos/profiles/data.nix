	{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.data;
in
{
  options.profiles.data.ssd = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Do you have an SSD disk?
      '';
  };
  options.profiles.data.username = mkOption {
      type = types.str;
      default = "fiction";
      description = ''
        Your username
      '';
  };
  options.profiles.data.diskuuid = mkOption {
      type = types.str;
      description = ''
        Disk UUID
      '';
  };
}
