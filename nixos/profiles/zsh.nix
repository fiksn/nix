{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.profiles.zsh;
in 
{
  options.profiles.zsh.enable = lib.mkEnableOption "Whether to enable my zsh";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      #history.size = 10000;
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
  };
}
