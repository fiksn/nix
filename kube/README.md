# Kubernetes playground

I want to try [Kubenix](https://github.com/xtruder/kubenix) and [Kubenix modules](https://github.com/xtruder/kubenix-modules/).

## Intro 

The idea is very simple, Kubenix is a Nix module generated from swagger k8s definitions. So no more editing ugly YAML files by hand.
Together with dockerTools.buildLayeredImage this should be a great improvement to my productivity. At least after I learn more about Nix language.

## Disclaimer

I am standing on the shoulders of giants. The code is shamelessly stolen from [https://github.com/gilligan/kind-kubenix](https://github.com/gilligan/kind-kubenix) and
[https://zimbatm.com/deploying-k8s-apps-with-kubenix/](https://zimbatm.com/deploying-k8s-apps-with-kubenix/) as well as from examples of Kubenix itself.

## Version

I am using the upcoming kubenix-2.0 branch. To generate checksum:
```
nix-prefetch-url --unpack https://github.com/xtruder/kubenix/archive/db5ee88274abfbc98ff98046bb6a96ee2f9c1e95.tar.gz
```

or even better:
```
nix-build -E 'with import <nixpkgs> {}; fetchFromGitHub { owner = "xtruder"; repo = "kubenix"; rev = "db5ee88274abfbc98ff98046bb6a96ee2f9c1e95"; sha256 = "0000000000000000000000000000000000000000000000000000"; }'
```

## Nix modules

Kubenix 2 is using modules like NixOS. [Writing NixOS Modules](https://nixos.org/nixos/manual/index.html#sec-writing-modules) is helpful here.
To make the example work I used ```{ _module.args.dockerImage = appImage; }``` as describe in this [StackOverflow answer](https://stackoverflow.com/questions/47650857/nixos-module-imports-with-arguments).
Of course this is just a toy example that is ugly. Will refactor to options eventually.

## Example

Can be run with:
```nix eval -f ./. --json foo```

```
nix run -f ./. pushDockerImages -c copy-docker-images
```

Test will spawn vm with kubernetes and run test script, which checks if everyting
works as expected.

```
nix build -f ./. test-script
cat result | jq '.'
```

