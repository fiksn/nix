{
  # First SSH key will be used anyway
  resources.sshKeyPairs.ssh-key = {};

  machine = { config, pkgs, ... }: {
    services.openssh.enable = true;

    deployment.targetEnv = "digitalOcean";
    # https://github.com/NixOS/nixops/issues/945 
    # export DIGITAL_OCEAN_AUTH_TOKEN="5c...."
    deployment.digitalOcean.authToken = import ../digitalocean-secret.nix;

    deployment.digitalOcean.enableIpv6 = true;
    deployment.digitalOcean.region = "ams3";
    deployment.digitalOcean.size = "s-1vcpu-1gb";
  };
}
