{ config, pkgs, ... }:
{
  # Home Manager configuration
  home.stateVersion = "25.05";
  home.username = "fiction";
  home.homeDirectory = "/home/fiction";

  programs.git = {
    enable = true;
    userName = "Gregor Pogačnik";
    userEmail = "1640719+fiksn@users.noreply.github.com";
  };

  services.redshift = {
    enable = true;
    latitude = 46.0;
    longitude = 14.0;
    settings = {
      redshift = {
        brightness-day = "1";
        brightness-night = "0.5";
      };
    };
    temperature.day = 6500;
    temperature.night = 3500;
  };
}
