{ pkgs ? import ../nixpkgs-stable.nix }:

let 
   python = import ./requirements.nix { inherit pkgs; };
   gems = pkgs.bundlerEnv {
     name = "aws-gems";
     ruby = pkgs.ruby;
     gemdir = ./.;
   };
in

pkgs.symlinkJoin { 
  name = "aws-tools";

  paths = [
    gems
  ] ++ builtins.attrValues python.packages;
}
