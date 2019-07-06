#import (builtins.fetchTarball {
#  name = "nixpkgs-19.03";
#  url = https://github.com/NixOS/nixpkgs/archive/19.03.tar.gz;
#  sha256 = "0q2m2qhyga9yq29yz90ywgjbn9hdahs7i8wwlq7b55rdbyiwa5dy";
#}) {}

# 19.03 doesn't really work :/

# According to nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version' I currently have
# 19.09pre182717.b58ada326aa or b58ada326aa612ea1e2fb9a53d550999e94f1985 on a workstation
# nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz

import (builtins.fetchTarball {
  name = "nixpkgs-stable";
  url = https://github.com/NixOS/nixpkgs/archive/b58ada326aa612ea1e2fb9a53d550999e94f1985.tar.gz;
  sha256 = "1y7f5ixsxfdmm02pz5kf039gy5j7y0lfdfzrkgl5kjblyzrkglm3";
}) {}
