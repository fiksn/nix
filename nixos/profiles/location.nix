{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.location;
in
{
  options.profiles.location = mkOption {
    type = types.enum [ "slovenia" "none" ];
    example = "slovenia";
    description = ''
      Your current location. 
    '';
  };

  config = mkIf (cfg == "slovenia") {
    services.ntp = {
      enable = true;
      servers = [ "ntp1.arnes.si" "ntp2.arnes.si" ];
    };
    time.timeZone = "Europe/Ljubljana";
    console.keyMap = "slovene";
    i18n = {
      #consoleFont = "lat9w-16";
      defaultLocale = "sl_SI.UTF-8";
    };
  };
}
