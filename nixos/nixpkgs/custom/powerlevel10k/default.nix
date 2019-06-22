{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "powerlevel10k";
  src = fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "08a26b7045feafde8eb5023c5bcf074a8ff42abc";
    sha256 = "1zcy78sdxwyg523bis1wmfrcnng7vwd4i6gnxr1ykcbfkrawji2p";
  };

  installPhase = ''
    mkdir -p $out/powerlevel10k
    mv * $out/powerlevel10k
  '';
}

