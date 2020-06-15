{ pkgs ? import ../nixpkgs-stable.nix }:

let 
   username = pkgs.lib.maybeEnv "ZRH_USERNAME" "g.pogacnik";

   awsConfigFileWriter = id: pkgs.writeTextFile {
     name = "aws-user-config";
     text = ''
       # Generated by Nix
       [default]
       region=eu-central-1
       azure_tenant_id=SportradarAG.onmicrosoft.com
       azure_app_id_uri=${id}
       azure_default_username=${username}@sportradar.com
       azure_default_role_arn=
       azure_default_duration_hours=1
     '';
   };

   awsConfig = awsConfigFileWriter "a43d895e-e3f3-42b9-bb13-3191f61ef11d";
   awsConfigSandbox = awsConfigFileWriter "2cd75673-2d37-4a7c-ac4c-5e163113adff";
   awsTools = pkgs.callPackage ./. { };

in

pkgs.mkShell {
  name = "aws";

  buildInputs = [
    pkgs.figlet
    pkgs.lolcat
    pkgs.coreutils
    pkgs.findutils
    pkgs.gnugrep
    pkgs.docker
    pkgs.ruby
    awsTools
  ];

  shellHook = ''
    export PS1='\n\[\033[1;32m\][aws:\w]\$\[\033[0m\] '
    figlet "AWS" | lolcat --freq 0.5
    echo "You now have aws and stack_master tools available in your shell."
    echo "For web-login use https://myapps.microsoft.com"
    echo "Regarding the login-prompt press CTRL-C if you have previously logged-in or ~/.aws/credentials still contains valid credentials."

    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo ""
      echo "!!!IMPORTANT!!!: Make sure under Docker / Preferences / Resources / File Sharing /nix is added"
      echo ""
    fi

    while true; do
      read -p "Use sandbox (y/n)? " choice
      case "$choice" in
        [Yy]* ) AWS_CONFIG=${awsConfigSandbox}; break;;
        [Nn]* ) AWS_CONFIG=${awsConfig}; break;;
        * ) echo "Please answer yes or no.";;
      esac
    done

    # if ~/.aws/config is pointing to nix store you can safely overwrite it
    mkdir -p ~/.aws
    if [ -L  ~/.aws/config ] && ($(readlink $AWS_CONFIG | grep -q '^/nix/store') || $(echo $AWS_CONFIG | grep -q '^/nix/store')); then
      ln -fs $AWS_CONFIG ~/.aws/config
    elif [ -f ~/.aws/config ]; then
      # Else backup and overwrite
      mv ~/.aws/config ~/.aws/config.$$
      echo "Backed up ~/.aws/config to ~/.aws/config.$$"
      ln -fs $AWS_CONFIG  ~/.aws/config
    else
      # No config file
      echo "We will create a ~/.aws/config pointing to nix store"
      ln -fs $AWS_CONFIG ~/.aws/config
    fi

    # Directly installing aws-azure-login through npm is a PITA
    docker run --rm -it -v ~/.aws:/root/.aws -v $AWS_CONFIG:$AWS_CONFIG dtjohnson/aws-azure-login
   
    aws sts get-caller-identity
    aws iam get-user
  '';
}
