# /etc/nixos/configuration-common.nix

{ config, pkgs, callPackage, lib, ... }:

with lib;

let data = import ./data.nix;
in
{
  imports =
    [ 
      ./profiles/virtualisation.nix
      ./profiles/zsh.nix
      ./profiles/i3.nix
      # or just use pkgs.nixopsUnstable
      ./profiles/nixops.nix
    ] ;

  profiles = {
    i3.enable = true;
    zsh.enable = true;
    virtualisation.enable = true;
  };
  
  nixpkgs = import ./nixpkgs;

  # Fingerprint reader (unfortunately drivers are not supported)
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  
  # Test
  #services.kubernetes = {
  #  roles = ["master" "node"];
  #  masterAddress = "127.0.0.1";
  #  apiserverAddress = "127.0.0.1";
  #  easyCerts = true;
  #};

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/${data.diskuuid}";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  fileSystems."/".options = if data.ssd then [ "noatime" "nodiratime" "discard" ] else [];

  boot.cleanTmpDir = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Or else I keep getting Corrected error dmesg spam
  boot.kernelParams = [ "pci=noaer" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "vm.overcommit_memory" = 1;
  };

  # wpa_passphrase MyWifiSSID MySecretPassword > wpa_supplicant.conf
  networking.wireless.enable = true;
  #networking.networkmanager.enable = true;

  powerManagement.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
  hardware.opengl.driSupport32Bit = true; 

  networking.hostName = "present";
 
  ####

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
    allowSFTP = true;
    forwardX11 = true;
    openFirewall = true;
  };
  
  services.ntp = {
    enable = true;
    servers = [ "ntp1.arnes.si" "ntp2.arnes.si" ];
  };
  
  # gnupg agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  #programs.sysdig.enable = true;
  programs.tmux.enable = true;

  users.mutableUsers = true;
  users.users.${data.username} = {
    isNormalUser = true;
    home = "/home/${data.username}";
    createHome = true;
    description = "Gregor";
    useDefaultShell = false;
    shell = (if config.profiles.zsh.enable then "/run/current-system/sw/bin/zsh" else pkgs.shadow);
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAMaDaMzVzsgxq64VQ3YTeBfENo96zK56ld0OU/jgi1"
    ];
    
    packages = with pkgs; (if config.profiles.i3.enable then [ slack vscode-with-extensions chromium firefox thunderbird libreoffice jetbrains.idea-community adobe-reader mplayer ] else []); 

    extraGroups= [
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

  #environment.variables = { EDITOR = "vim"; };
  programs.vim.defaultEditor = true;

  time.timeZone = "Europe/Ljubljana";
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "slovene";
    defaultLocale = "sl_SI.UTF-8";
  };

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
      #envsubst
      file
      fuse_exfat
      gcc
      gdb
      git
      gnupg
      gosu
      htop
      jhead
      jq
      ltrace
      mosh
      netcat
      ngrep
      nmap
      ntp
      openssl
      pssh
      pv
      pwgen
      s3fs
      screen
      strace
      sshfs
      tig
      tmux
      tshark
      unzip
      vim
      wget
      
      ntfs3g
      rsync
      iotop
      disnix
      dhcp
      telnet
      irssi
  ];


  nix.package = pkgs.nixUnstable;
  nix.useSandbox = true;

  # automatic gc
  nix.gc = {
    automatic = true;
    dates = "03:15";
    options = "--delete-older-than 30d";
  };
  
  services.nixosManual.showManual = false;
  documentation.man.enable = true;

  # disable the infamous systemd screen/tmux killer
  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

  
}
