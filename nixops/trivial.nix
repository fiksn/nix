{
  network.description = "Testing";

  testserver =
    { config, pkgs, ... }:
    { 
      programs.mosh.enable = true;
      virtualisation.docker.enable = true;
      environment.systemPackages = with pkgs; [ docker docker_compose skopeo docker-ls ];
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "vm.overcommit_memory" = 1;
      };

      services.ssh.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 ]; 
    };
}
