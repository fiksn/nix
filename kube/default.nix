{ pkgs ? import <nixpkgs> {} }:

let
  kubenix = pkgs.callPackage ./lib/kubenix.nix {};

  manifest = kubenix.evalModules {
    modules = [
      ./modules/docker.nix
      ./modules/kubernetes.nix
    ];
  };

  result = with kubenix.lib; k8s.mkHashedList { items = manifest.config.kubernetes.objects; };
  
in
  { export = manifest.config.docker.export; foo = manifest.config.docker.copyScript; }
   
