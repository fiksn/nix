{ pkgs ? import <nixpkgs> {} }:

let
  kubenix = pkgs.callPackage ./modules/kubenix.nix {};

  appImage = pkgs.dockerTools.buildLayeredImage {
    name = "hello-app";
    tag = "latest";
    config.Cmd = [ "${pkgs.coreutils}/bin/ls" ];
  };

  /* OOOLD
  configuration = import ./legacy.nix {};
  manifest = kubenix.buildResources {
    inherit configuration;
    writeJSON = false;
  };
  */

  manifest = kubenix.evalModules {
    modules = [
      ./modules/kubernetes.nix
      { docker.registry.url = "dockerhub.com"; }
      { _module.args.dockerImage = appImage; }
    ];
  };

  result = with kubenix.lib; k8s.mkHashedList { items = manifest.config.kubernetes.objects; };
  
in
  { foo = result; }
   
