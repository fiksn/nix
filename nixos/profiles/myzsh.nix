{ config, pkgs, ... }:

{
let
  cfg = config.myzsh;
in 
  options.myzsh {
     enable = mkOption {
        default = false;
        description = ''
          Whether to enable the my zsh
        '';
        type = types.bool;
      };
  }; 

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = true;
    }

    environment.systemPackages = with pkgs; [ zsh-git-prompt ];
    environment.shells = [
      "/run/current-system/sw/bin/zsh"
      ];
  };
}
