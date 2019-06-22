{ username ? "g.pogacnik" }:

let 
   pkgs = import <nixpkgs> {};
   python = import ./requirements.nix { inherit pkgs; };
   gems = pkgs.bundlerEnv {
     name = "aws-gems";
     ruby = pkgs.ruby;
     gemdir = ./.;
   };

   awsConfig = pkgs.writeTextFile {
     name = "aws-user-config";
     text = ''
       # Generated by Nix
       [default]
       region=eu-central-1
       azure_tenant_id=SportradarAG.onmicrosoft.com
       #azure_app_id_uri=a43d895e-e3f3-42b9-bb13-3191f61ef11d
       azure_app_id_uri=2cd75673-2d37-4a7c-ac4c-5e163113adff
       azure_default_username=${username}@sportradar.com
       azure_default_role_arn=
       azure_default_duration_hours=1
     '';
   };

in

pkgs.stdenv.mkDerivation {
  name = "aws";

  buildInputs = [
    pkgs.figlet
    pkgs.lolcat
    pkgs.coreutils
    pkgs.findutils
    pkgs.gnugrep
    pkgs.docker
    pkgs.ruby
    gems
    python.packages."beautifulsoup4"
    python.packages."boto3"
    python.packages."boto"
    python.packages."awscli"
  ];

  shellHook = ''
    export PS1='\n\[\033[1;32m\][aws:\w]\$\[\033[0m\] '
    figlet "AWS" | lolcat --freq 0.5
    echo "You now have aws and stack_master tools available in your shell."
    echo "For web-login use https://myapps.microsoft.com"
    echo "Regarding the login-prompt press CTRL-C if you have previously logged-in or ~/.aws/credentials still contains valid credentials."

    # if ~/.aws/config is pointing to nix store you can safely overwrite it
    mkdir -p ~/.aws
    if [ -L  ~/.aws/config ] && $(readlink -f ${awsConfig} | grep -q '^/nix/store'); then
      ln -fs ${awsConfig} ~/.aws/config  
    elif [ -f ~/.aws/config ]; then
      # Else backup and overwrite
      mv ~/.aws/config ~/.aws/config.$$
      echo "Backed up ~/.aws/config to ~/.aws/config.$$"
      ln -fs ${awsConfig} ~/.aws/config  
    else
      # No config file
      echo "We will create a ~/.aws/config pointing to nix store"
      ln -fs ${awsConfig} ~/.aws/config
    fi

    # Directly installing aws-azure-login through npm is a PITA
    docker run --rm -it -v ~/.aws:/root/.aws -v ${awsConfig}:${awsConfig} dtjohnson/aws-azure-login
   
    aws sts get-caller-identity
    aws iam get-user
  '';
}
