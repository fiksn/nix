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
  url = https://github.com/NixOS/nixpkgs/archive/cae7840b7639c56ad619cb8fb8f921298ae385b7.tar.gz;
  sha256 = "1mr5bp3vnag9nihcz1l0hdvm2n8n7lm84qh3cynbp00rcpwy0mhc";
}) {}

