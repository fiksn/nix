{ pkgs, ... }:

{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "vm.overcommit_memory" = 1;
  };

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  environment.interactiveShellInit = ''
    alias vi='vim'
  '';

  environment.systemPackages = with pkgs; [
      sysPackages

      corkscrew
      proxychains

      ntfs3g
      disnix
      kea
      irssi
  ];

  programs.tmux.enable = true;
}
