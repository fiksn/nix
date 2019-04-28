# /etc/nixos/kubernetes.nix

{ config, pkgs, ... }:

{
  services.kubernetes.roles = ["master" "node"];
  environment.systemPackages = with pkgs; [ kubernetes kubernetes-helm kops minikube.bin kubectx ];
}
