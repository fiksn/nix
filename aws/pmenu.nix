{ stdenv 
, python3
, fetchFromGitHub
}:

let
  py = python3;
in
stdenv.mkDerivation rec {
  pname = "pmenu";
  version = "v0.3.3"; 

  src = fetchFromGitHub {
    owner = "sgtpep";
    repo = "pmenu";
    rev = version;
    hash = "sha256:07j0l0x39gfk54r9pq7lzwfcv9z6srccm3j8brhh9m0f592pp51x";
  };
 
  installPhase = ''
    mkdir -p $out/bin

    install -D -m555 pmenu $out/bin/pmenu 
  '';

  # No tests included
  doCheck = false;
}
