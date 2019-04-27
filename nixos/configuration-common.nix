# /etc/nixos/configuration-common.nix

{ config, pkgs, callPackage, ... }:

let data = import ./data.nix;
in
{
  imports =
    [ 
      ./x.nix
      ./virtualization.nix
    ] ++ (if data.zsh then [ ./zsh.nix ] else []);

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
  
  # gnupg agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.sysdig.enable = true;
  programs.tmux.enable = true;

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
  i18n.defaultLocale = "sl_SI.UTF-8";
  i18n.consoleKeyMap = "sl";
 

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

  ] ++ (if data.gui then with pkgs; [
      gnome3.gnome-screenshot
      gparted
      wireshark-gtk
      xorg.xbacklight
      pavucontrol
      playerctl
      scrot 
  ] else []);


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
