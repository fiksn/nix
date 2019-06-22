{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel10k";
  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "master";
    sha256 = "1c4ah34zcgs4319kf2g6k4v4paa99w6n5l3b8p2yldav7m7i42gv";
  };

  installPhase = ''
    mkdir -p $out/powerlevel10k
    mv * $out/powerlevel10k
  '';
}

