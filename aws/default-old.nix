with (import <nixpkgs> {});
let
  gems = bundlerEnv {
    name = "fiction-package";
    inherit ruby;
    gemdir = ./.;
  };
in stdenv.mkDerivation {
  name = "fiction-package";
  buildInputs = [gems ruby];
}
