{ pkgs }:

# ffaa36d7f0173cf03989344a2fd8fa6d311057b1 -> 1gjb6wpw8s6gy39clqq3ddmmlpcpscfzcqkbcg07gw456ak5vjhh latest
# db5ee88274abfbc98ff98046bb6a96ee2f9c1e95 -> 0yzhhz4p6g2xy96vfdzp47x24y4x8h9z5d9v2mqcpfax7w0czy4b kubenix-2.0

if (builtins.tryEval (import <kubenix>)).success
    then import <kubenix>

    else import (pkgs.fetchFromGitHub {
      owner = "xtruder";
      repo = "kubenix";
      rev = "db5ee88274abfbc98ff98046bb6a96ee2f9c1e95";
      sha256 = "0yzhhz4p6g2xy96vfdzp47x24y4x8h9z5d9v2mqcpfax7w0czy4b";
    }
) { inherit pkgs; }
