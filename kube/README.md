# Kubernetes playground

I want to try [Kubenix](https://github.com/xtruder/kubenix) and [Kubenix modules](https://github.com/xtruder/kubenix-modules/).

## Intro 

The idea is very simple, Kubenix is a Nix module generated from swagger k8s definitions. So no more editing ugly YAML files by hand.
Together with dockerTools.buildLayeredImage this should be a great improvement to my productivity. At least after I learn more about Nix language.

## Disclaimer

I am standing on the shoulders of giants. The code is shamelessly stolen from [https://github.com/gilligan/kind-kubenix](https://github.com/gilligan/kind-kubenix) and
[https://zimbatm.com/deploying-k8s-apps-with-kubenix/](https://zimbatm.com/deploying-k8s-apps-with-kubenix/).

## Version

I am using the upcoming kubenix-2.0 branch. To generate checksum:
```
nix-prefetch-url --unpack https://github.com/xtruder/kubenix/archive/db5ee88274abfbc98ff98046bb6a96ee2f9c1e95.tar.gz
```

```
nix-build -E 'with import <nixpkgs> {}; fetchFromGitHub { owner = "xtruder"; repo = "kubenix"; rev = "db5ee88274abfbc98ff98046bb6a96ee2f9c1e95"; sha256 = "0000000000000000000000000000000000000000000000000000"; }'
```

## Example

Can be run with:
```nix eval -f ./. --json foo```
