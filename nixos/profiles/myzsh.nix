{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myzsh;
in 
{
  options.myzsh = {
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
      enableAutosuggestions = true;
      enableCompletion = true;
      #dotDir = ".config/zsh";
      #history = {
	#expireDuplicatesFirst = true;
	#extended = true;
	#ignoreDups = true;
	#path = ".config/zsh/history";
	#save = 1000000;
	#share = true;
	#size = 1000000;
      #};
      ohMyZsh = {
	enable = true;
	plugins = [
	  "common-aliases"
	  "compleat"
	  "dirhistory"
	  "encode64"
	  "fasd"
	  "git"
	  "git-extras"
	  "git-prompt"
	  "nix"
	  "per-directory-history"
	  "sudo"
	  "systemd"
	  "vi-mode"
	  "wd"
	];
	theme = "../../../../../..${pkgs.powerlevel10k}/powerlevel10k/powerlevel10k";
      };
      #sessionVariables = {
	#TERM = "xterm-256color";
      #};
      #initExtra = ''
	#${builtins.readFile ./powerlevel10k_init.zsh};
	#compinit
      #'';
    };

    environment.systemPackages = with pkgs; [ zsh-git-prompt nix-zsh-completions zsh-completions ];
    environment.shells = [
      "/run/current-system/sw/bin/zsh"
      ];
  };
}
