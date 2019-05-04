# /etc/nixos/virtualization.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myvirt;
in
{
  options.myvirt = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable virtualization. 
        '';
        type = types.bool;
      };
  };
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;  
    environment.systemPackages = with pkgs; [ docker docker_compose skopeo docker-ls ];
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation.libvirtd.enable = true;
  };
}
