{ config, pkgs, callPackage, lib, ... }:

with lib;
with builtins;

let 

content = dir: filter (hasSuffix ".nix") (attrNames (readDir dir));
# get a list of all files ending in .nix
all = dir: map (a: dir + "/${a}") (content dir);

in
{
  nixpkgs = import ./nixpkgs;

  imports =
    [ ./data.nix ./nix.nix ] ++
    (all ./profiles);

  profiles = {
    i3.enable = true;
    zsh.enable = true;
    virtualisation.enable = true;
    automount.enable = true;
    fingerprint.enable = true;
    location = "slovenia";
  };

  # Test
  #services.kubernetes = {
  #  roles = ["master" "node"];
  #  masterAddress = "127.0.0.1";
  #  apiserverAddress = "127.0.0.1";
  #  easyCerts = true;
  #};

  networking.hostName = "present";

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/${config.profiles.data.diskuuid}";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  fileSystems."/".options = if config.profiles.data.ssd then [ "noatime" "nodiratime" "discard" ] else [];

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

  #programs.sysdig.enable = true;
  programs.tmux.enable = true;

  users.mutableUsers = true;
  users.users.${config.profiles.data.username} = {
    isNormalUser = true;
    home = "/home/${config.profiles.data.username}";
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


}
