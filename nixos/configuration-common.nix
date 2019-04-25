# /etc/nixos/configuration-common.nix

{ config, pkgs, callPackage, ... }:

let data = import ./data.nix;
in
{
  imports =
    [ 
      ./x.nix
    ];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/644e1f44-c76b-4cb8-9c53-485d7c006d64";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # only for ssd
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot.cleanTmpDir = true;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "vm.overcommit_memory" = 1;
  };

  # wpa_passphrase MyWifiSSID MySecretPassword > wpa_supplicant.conf
  networking.wireless.enable = true;
  #networking.networkmanager.enable = true;

  powerManagement.enable = true;
  hardware.bluetooth.enable = true;

  networking.hostName = "present";
 
  ####

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  users.users.fiction = {
    isNormalUser = true;
    home = "/home/fiction";
    createHome = true;
    description = "Gregor";
    useDefaultShell = false;
    shell = "/run/current-system/sw/bin/zsh";
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAMaDaMzVzsgxq64VQ3YTeBfENo96zK56ld0OU/jgi1"
    ];

    
    packages = with pkgs; [ slack vscode-with-extensions chromium firefox thunderbird libreoffice jetbrains.idea-community adobe-reader mplayer ]; 

    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "users"
      "vboxusers"
      "video"
      "wheel"
      "fuse"
    ];
  };


  environment.variables = { EDITOR = "vim"; };
  time.timeZone = "Europe/Ljubljana";
 
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  #environment.systemPackages = with pkgs; [ zsh zsh-git-prompt oh-my-zsh ] ++ environment.systemPackages;
  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];

  virtualisation.docker.enable = true;  
  #environment.systemPackages = with pkgs; [ docker docker_compose ] ++ environment.systemPackages;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  security.hideProcessInformation = true;

  environment.systemPackages = with pkgs; [
      bash
      bc
      coreutils
      curl
      dos2unix
      fuse_exfat
      gcc
      gdb
      git
      gnupg
      gosu
      htop
      jhead
      jq
      mosh
      netcat
      ngrep
      nmap
      ntp
      openssl
      pv
      pwgen
      s3fs
      screen
      sshfs
      tig
      tmux
      tshark
      unzip
      vim
      wget

      gnome3.gnome-screenshot
      gparted
      wireshark-gtk
      xorg.xbacklight
      pavucontrol
      playerctl
      scrot
  ];


  nix.package = pkgs.nixUnstable;
  nix.useSandbox = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.pulseaudio = true;
  nixpkgs.config.dmenu.enableXft = true;

  nixpkgs.config.firefox = {
   enableGoogleTalkPlugin = true;
   enableAdobeFlash = true;
   enableAdobeFlashDRM = true;
   jre = false;
   icedtea = true;
  };
  nixpkgs.config.chromium = {
   enablePepperFlash = true;
   enableWideVine = true;
   enabePepperPDF = true;
   jre = false;
   icedtea = true;
  };


  documentation.man.enable = true;

  hardware.opengl.driSupport32Bit = true; 

  # gnupg agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # automatic gc
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "--delete-older-than 30d";
  };

  
}
