{ sources ? import ../nix/sources.nix
, pkgs ? import sources.nixpkgs {}
, master ? import sources.master {}
}:

let 
   awscli = pkgs.awscli2;
   python = awscli.passthru.python;
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
    awscli

    master.python38Packages.boto3
    #python.pkgs.boto3

    master.python38Packages.ec2instanceconnectcli
    master.python38Packages.cfn-lint
  ];
}
