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
    python.packages."beautifulsoup4"
    python.packages."boto3"
    python.packages."boto"
    python.packages."awscli"
    python.packages."cfn-lint"
    python.packages."ec2instanceconnectcli"
  ];
}
