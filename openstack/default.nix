{ pkgs ? import ../nixpkgs-stable.nix }:

let 
   python = import ./requirements.nix { inherit pkgs; };
in

pkgs.symlinkJoin {
  name = "openstack-tools";

  paths = [
    pkgs.openssh
    pkgs.squid
    python.packages."python-openstackclient"
    python.packages."python-novaclient"
    python.packages."python-cinderclient"
    python.packages."python-keystoneclient"
    python.packages."python-glanceclient"
    python.packages."python-heatclient"
    python.packages."python-swiftclient"
    python.packages."ipcalc"
    python.packages."ruamel-yaml"
    python.packages."deepdiff"
  ];

}
