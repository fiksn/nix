{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Monoid HalfTight Semi-Condensed" "Source Code Pro For Powerline" "Roboto Mono" "DejaVu Sans Mono" ];
        sansSerif = [ "Monoid HalfTight Semi-Condensed" "Roboto Regular" "DejaVu Sans" ];
        serif = [ "Roboto Slab Regular" "DejaVu Serif" ];
      };
    };
    enableDefaultFonts = true;
    fonts = [
      pkgs.anonymousPro
      pkgs.arkpandora_ttf
      pkgs.caladea
      pkgs.carlito
      pkgs.comfortaa
      pkgs.comic-relief
      pkgs.crimson
      pkgs.dejavu_fonts
      pkgs.dejavu_fonts
      pkgs.google-fonts
      pkgs.inconsolata
      pkgs.liberation-sans-narrow
      pkgs.liberation_ttf
      pkgs.libertine
      pkgs.mononoki
      pkgs.montserrat
      pkgs.norwester-font
      pkgs.open-sans
      pkgs.powerline-fonts
      pkgs.roboto
      pkgs.sampradaya
      pkgs.source-code-pro
      pkgs.source-sans-pro
      pkgs.source-serif-pro
      pkgs.tai-ahom
      pkgs.tempora_lgc
      pkgs.terminus_font
      pkgs.theano
      pkgs.ubuntu_font_family
      pkgs.vistafonts
      pkgs.corefonts
      # Broken
      #pkgs.monoid
    ];
  };

  #i18n.consoleFont = "Hack";

  #environment.systemPackages = [
  #  pkgs.tamzen-console-font
  #];
}
