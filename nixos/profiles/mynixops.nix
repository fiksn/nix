# A rather convoluted way to install recent NixOps
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.mynixops;
  nixops = lib.fetchFromGitHub { 
      owner = "NixOS"; 
      repo = "nixops"; 
      rev = "b460872a15b863ed7caa52e36d574f105c4c471a"; 
      sha256 = "1jvblbrp9iankf5hnwq09vviqij4j19skvldakrkbd4z2q1jr9vz"; 
  };
  pkg = stdenv.mkDerivation {
      name = "mynixops";
      buildInputs = [
        (import "${nixops}/release.nix" {}).build.x86_64-linux
      ];
  };
in
{
  options.mynixops = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable nixops. 
        '';
        type = types.bool;
      };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkg ];
  };
}
