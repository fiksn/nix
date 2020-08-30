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
    [ ./cachix.nix ] ++ 
    [ ./data.nix ./roles/common.nix ./nix.nix ./fonts.nix ] ++
    # Other stuff
    [ ./other/qemu.nix ] ++
    (all ./profiles); 

  profiles = {
    i3.enable = true;
    zsh.enable = true;
    virtualisation.enable = true;
    automount.enable = true;
    fingerprint.enable = true;
    security.enable = true;
    location = "slovenia";
  };

  # Other stuff
  qemu-user = {
    arm = true;
    aarch64 = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      ''experimental-features = nix-command flakes
        keep-outputs = true
      '';
  };

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "enp3s0" ];
    extraConfig = ''
      option subnet-mask 255.255.255.0;
      option routers 192.168.2.1;
      option domain-name-servers 1.1.1.1;
      subnet 192.168.2.0 netmask 255.255.255.0 {
        range 192.168.2.2 192.168.2.3;
      }
    '';
  };

  # Test
  #services.kubernetes = {
  #  roles = ["master" "node"];
  #  masterAddress = "127.0.0.1";
  #  apiserverAddress = "127.0.0.1";
  #  easyCerts = true;
  #};

  ### 

  networking.hostName = "present";

  system.stateVersion = "20.03";

  boot.initrd.luks.devices = 
  {
    root = { 
      device = "/dev/disk/by-uuid/644e1f44-c76b-4cb8-9c53-485d7c006d64";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot.kernelPackages = pkgs.linuxPackages_5_4;

  # Or else I keep getting Corrected error dmesg spam
  boot.kernelParams = [ "pci=noaer" ];

  ## laptop

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

  # xbacklight alternative
  environment.systemPackages = with pkgs; [ acpilight ];

  # Allow brightness settings for video group
  services.udev = {
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    '';
  };
  
  ## laptop
 
  ####

  services.trezord.enable = true;
  services.redsocks = {
    enable = true;
      redsocks = [
        {
        port = 1080;
        proxy = "127.0.0.1:2080";
        type = "socks5";
        redirectCondition = false;
      }
     ];
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
    allowSFTP = true;
    forwardX11 = true;
    openFirewall = true;
  };
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = config.services.openssh.enable;
  };

  #programs.sysdig.enable = true;
  programs.adb.enable = true;

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
      "socksified"
      "libvirtd"
    ];
  };



}
