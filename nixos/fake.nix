# This is used only for testing
let
  system = builtins.currentSystem;

  # (import <nixpkgs/nixos/lib/eval-config.nix> { modules = [./ops/webserver.nix]; }).config.systemd.units."blank-me-up.service".text'
  pkgs = import <nixpkgs> {
    inherit system;
    inherit (ccc.config.nixpkgs) config overlays;
  };

  ccc = import <nixpkgs/nixos/lib/eval-config.nix> {
    inherit system pkgs;
    modules = [ ./configuration.nix ];
  };
in
  ccc.config.nixpkgs.config
