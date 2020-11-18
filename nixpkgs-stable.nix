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
  url = https://github.com/NixOS/nixpkgs/archive/cd63096d6d887d689543a0b97743d28995bc9bc3.tar.gz;
  sha256 = "sha256:1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
}) {}

