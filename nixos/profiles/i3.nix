{ config, pkgs, lib, ... }:

with lib;

let 
    cfg = config.profiles.i3;
    dunstrc = builtins.toFile "dunstrc" (pkgs.lib.readFile ./config/dunstrc);
    background-image = pkgs.fetchurl {
      url = "http://orig01.deviantart.net/1810/f/2012/116/a/4/tranquility_by_andreewallin-d4xjtd0.jpg";
      sha256 = "17jcvy268aqcix7hb8acn9m9x7dh8ymb07w4f7s9apcklimz63bq";
    };
    solarized-theme = pkgs.fetchFromGitHub {
      owner = "anderspapitto";
      repo = "nixos-solarized-slim-theme";
      rev = "2822b7cb7074cf9aa36afa9b5cabd54105b3306c";
      sha256 = "0jp7qq02ly9wiqbgh5yamwd31ah1bbybida7mn1g6qpdijajf247";
    };
    simpleXService = name: description: execStart: {
      inherit description;
      environment = {
        DISPLAY = ":0";
      };
      serviceConfig = {
        Type = "simple";
        User = "${config.profiles.data.username}";
        ExecStart = pkgs.writeScript name ''
            #! ${pkgs.bash}/bin/bash
            . ${config.system.build.setEnvironment}
            set -xe
            ${execStart}
          '';
        RestartSec = 3;
        Restart = "always";
      };
      wantedBy = [ "display-manager.service" ];
      after = [ "display-manager.service" ];
    };
in 
{
  options.profiles.i3.enable = lib.mkEnableOption "Whether to enable the i3 GUI";

  config = mkIf cfg.enable {

    environment = {
      systemPackages = with pkgs; [
        gnome-screenshot
        xautolock
        gparted
        wireshark-qt
        pavucontrol
        playerctl
        scrot
        dzen2
        gnupg
        lxrandr
        nitrogen
      ];

      etc = {
	"picom/inverted"            .source = ./config/compton-inverted;
	"picom/noninverted"         .source = ./config/compton-noninverted;
	"dunst/dunstrc"             .source = ./config/dunstrc;
	"i3/config"                 .source = ./config/i3;
	"i3/status"                 .source = ./config/i3status;
	"i3/status-netns"           .source = ./config/i3status-netns;
	"X11/xresources"            .source = ./config/xresources;
	"display.sh"                .source = ./config/display.sh;
	"lock.sh"                   .source = ./config/lock.sh;
      };
    };

    environment.pathsToLink = [ "/libexec" ];

    programs.dconf.enable = true;

    services = {
      dbus.packages = [ pkgs.dconf ];
      libinput.enable = true;

      displayManager = {
        defaultSession = "xfce+i3";
      };

      xserver = {
	enable = true;
	xkb.layout = "si";

	desktopManager = {
	  session = [
	    {
	      name = "custom";
	      start = ''
		# Set background
		${pkgs.feh}/bin/feh --bg-scale ${background-image}

		# Load custom Xresources
	        ${pkgs.xorg.xrdb}/bin/xrdb /etc/X11/xresources

		# Start notifications
		${pkgs.dunst}/bin/dunst -config /etc/dunst/dunstrc &
	      '';
	    }
	  ];

	  xterm.enable = false;
	  xfce = {
	    enable = true;
	    noDesktop = true;
	    enableXfwm = false;
	  };
	};

	windowManager.i3 = {
	  enable = true;
	  extraPackages = with pkgs; [
	    dmenu #application launcher most people use
	    i3status # gives you the default i3 status bar
	    i3lock #default i3 screen locker
	    i3blocks #if you are planning on using i3blocks over i3status
	    i3-gaps
            rofi
            zenity
            xfce.xfce4-taskmanager
	  ];
	};
      };
    };

    systemd.services = {
      picom = simpleXService "picom"
	"lightweight compositing manager"
	"${pkgs.picom}/bin/picom --config /etc/picom/noninverted"
	;
      picom-night =
	let base-service = simpleXService "picom-night"
	      "lightweight compositing manager (night mode)"
	      "${pkgs.picom}/bin/picom --config /etc/picom/inverted"
	      ;
	in base-service // {
	    conflicts = [ "picom.service" ];
	    wantedBy = [ ];
	};
      dunst = simpleXService "dunst"
	"Lightweight libnotify server"
	"exec ${pkgs.dunst}/bin/dunst -config /etc/dunst/dunstrc"
	;
      feh = simpleXService "feh"
	"Set background"
	''
	  ${pkgs.feh}/bin/feh --bg-fill --no-fehbg ${background-image}
	  exec sleep infinity
	''
	;
      xbanish = simpleXService "xbanish"
	"xbanish hides the mouse pointer"
	"exec ${pkgs.xbanish}/bin/xbanish"
	;
      clipit = simpleXService "clipit"
	"clipboard manager"
	"exec ${pkgs.clipit}/bin/clipit"
	;
      xrdb = simpleXService "xrdb"
	"set X resources"
	''
	  ${pkgs.xorg.xrdb}/bin/xrdb /etc/X11/xresources
	  exec sleep infinity
	'';
    };


  };
}
