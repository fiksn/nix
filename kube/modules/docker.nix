{ config, pkgs, lib, kubenix,  ... }:

with lib;
{
  imports = with kubenix.modules; [ docker ];

  docker.registry.url = "dockerhub.com";

  docker.images.test.image = pkgs.dockerTools.buildLayeredImage {
    name = "hello-app";
    tag = "latest";
    config.Cmd = [ "${pkgs.coreutils}/bin/ls" ];
  };
}

