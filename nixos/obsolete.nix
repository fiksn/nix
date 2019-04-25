{ config, pkgs, callPackage, ... }:
{
  systemd.services.battery_check = {
    description = "Send notification if battery is low";
    serviceConfig = {
      Type = "oneshot";
      User = "fiction";
      ExecStart = pkgs.writeScript "battery_check" ''
        #!${pkgs.bash}/bin/bash --login
        . <(udevadm info -q property  -p /sys/class/power_supply/BAT0 |
            grep -E 'POWER_SUPPLY_(CAPACITY|STATUS)=')
        if [[ $POWER_SUPPLY_STATUS = Discharging && $POWER_SUPPLY_CAPACITY -lt 15 ]];
        then notify-send -u critical "Battery is low: $POWER_SUPPLY_CAPACITY";
        fi
      '';
    };
    environment = { DISPLAY = ":0"; };
    after = [ "display-manager.service" ];
    startAt = "*:00/5";
  };
};
