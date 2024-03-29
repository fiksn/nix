{ sources ? import ../nix/sources.nix
, pkgs ? import sources.nixpkgs {}
, master ? import sources.master {}
}:

let 
   asmr = pkgs.writeShellScriptBin "asmr" ''
     PROJECT=''${PROJECT:-"mts"}
     ALL=''${ALL:-"false"}
     if [ "$ALL" = "true" ]; then
       aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | (.InstanceId + "|" + .InstanceType + "|" + .PrivateIpAddress + "|" + .PublicIpAddress + "|" + .Placement.AvailabilityZone + "|" + .State.Name + "|" + .LaunchTime + "|" + .ImageId) + "|" + ((.Tags // [ { "Key": "Name", "Value": "" } ])[] | select(.Key=="Name") | .Value)'
     else
       aws ec2 describe-instances --filters "Name=tag:Project,Values=$PROJECT" | jq -r '.Reservations[].Instances[] | (.InstanceId + "|" + .InstanceType + "|" + .PrivateIpAddress + "|" + .PublicIpAddress + "|" + .Placement.AvailabilityZone + "|" + .State.Name + "|" + .LaunchTime + "|" + .ImageId) + "|" + ((.Tags // [ { "Key": "Name", "Value": "" } ])[] | select(.Key=="Name") | .Value)'
       aws ec2 describe-instances --filters "Name=tag:KubernetesCluster,Values=*$PROJECT*" | jq -r '.Reservations[].Instances[] | (.InstanceId + "|" + .InstanceType + "|" + .PrivateIpAddress + "|" + .PublicIpAddress + "|" + .Placement.AvailabilityZone + "|" + .State.Name + "|" + .LaunchTime + "|" + .ImageId) + "|" + ((.Tags // [ { "Key": "Name", "Value": "" } ])[] | select(.Key=="Name") | .Value)'
     fi
   '';

   awsTools = pkgs.callPackage ./. { };
in
pkgs.mkShell {
  name = "aws";

  buildInputs = [
    asmr
    master.direnv
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
    if [ -n "$AWS_PROMPT_SHOWN" ]; then
      return
    fi

    export AWS_PROMPT_SHOWN="true"
    export AWS_DEFAULT_REGION="eu-central-1"
    eval "$(direnv hook bash)"
    export PS1='\n\[\033[1;32m\][aws:\w]\$\[\033[0m\] '
    figlet "AWS" | lolcat --freq 0.5
    echo "You now have aws and stack_master tools available in your shell."
    echo "For web-login use https://myapps.microsoft.com"
    echo "Regarding the login-prompt press CTRL-C if you have previously logged-in or ~/.aws/credentials still contains valid credentials."

    $AWS_CHOICE

    aws sts get-caller-identity
    #aws iam get-user
  '';
}
