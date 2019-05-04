# /etc/nixos/configuration-common.nix

{ config, pkgs, callPackage, ... }:

let data = import ./data.nix;
in
{
  imports =
    [ 
      ./profiles/virtualization.nix
      ./profiles/myzsh.nix
      ./profiles/i3-special.nix
    ] ;

  i3-special.enable = true;
  myzsh.enable = true;
  myvirt.enable = true;
  services.kubernetes.roles = ["master" "node"];

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

  programs.sysdig.enable = true;
  programs.tmux.enable = true;

  users.mutableUsers = false;
  users.users.${data.username} = {
    isNormalUser = true;
    home = "/home/${data.username}";
    createHome = true;
    description = "Gregor";
    useDefaultShell = false;
    shell = (if data.zsh then "/run/current-system/sw/bin/zsh" else pkgs.shadow);
    openssh.authorizedKeys.keys = [ 
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAMaDaMzVzsgxq64VQ3YTeBfENo96zK56ld0OU/jgi1"
    ];
    
    packages = with pkgs; (if data.gui then [ slack vscode-with-extensions chromium firefox thunderbird libreoffice jetbrains.idea-community adobe-reader mplayer ] else []); 

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
      pssh
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
      
      ntfs3g
      rsync
      iotop
      nixops
      disnix
  ];


  nix.package = pkgs.nixUnstable;
  nix.useSandbox = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    pulseaudio = true;
    dmenu.enableXft = true;
  };

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
