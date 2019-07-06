{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.virtualisation;
in
{
  options.profiles.virtualisation.enable = lib.mkEnableOption "Whether to enable virtualisation";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;  
    environment.systemPackages = with pkgs; [ docker docker_compose skopeo docker-ls ];
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation.libvirtd.enable = true;
  };
}
