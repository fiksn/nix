{
  network.description = "Testing";

  testserver =
    { config, pkgs, ... }:
    { 
      programs.mosh.enable = true;
      virtualisation.docker.enable = true;
      environment.systemPackages = with pkgs; [ docker docker_compose skopeo docker-ls ];

      services.ssh.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ]; 
    };
}
