{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;

  programs.git = {
    enable = true;
    userName = "Gregor Pogačnik";
    email = "1640719+fiksn@users.noreply.github.com";
  };

  services.redshift = {
    enable = true;
    latitude = "46";
    longitude = "14";
    brightness.day = "1";
    brightness.night = "0.5";
    temperature.day = 6500;
    temperature.night = 3500;
  };

}
