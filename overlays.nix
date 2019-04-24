# ~/.config/nixpkgs/overlays.nix

let
  overlay1 = self: super:
  {
    myHaskell =
      super.haskellPackages.ghcWithPackages
	(haskellPackages: with haskellPackages; [
	   mtl QuickCheck random text alex cabal-install cpphs happy ghc-paths set-monad
	]);

    # nix-shell -p maven
    maven = super.maven.override {
      jdk = super.zulu;
    };

    sysPackages = super.buildEnv {
      name = "sys-packages";
      paths = with super; [ bash bc coreutils curl dos2unix git gosu htop jq mosh ngrep ntp openssl pv pwgen screen tcpdump tig tmux unzip vim wget xz ];
    };

    pwnPython = super.python27.withPackages (ps: with ps; [ numpy pwntools pip ]);

    hackPackages = super.lib.hiPrio (super.buildEnv {
      name = "hack-packages";
      paths = with super; [ aircrack-ng gdb gmp jhead john metasploit nmap radare2 z3 ghidra-bin self.pwnPython ];
    });

    jvmPackages = super.lib.hiPrio (super.buildEnv {
      name = "jvm-packages";
      paths = with super; [ ant findbugs maven scala visualvm zulu ];
    });

    devPackages = super.lib.hiPrio (super.buildEnv {
      name = "dev-packages";
      paths = with super; [ go nodejs yarn jvmPackages myHaskell ];
    });

    opsPackages = super.lib.hiPrio (super.buildEnv {
      name = "ops-packages";
      paths = with super; [ kubernetes vault redis mongodb mysql57 ];
    });
  };
in
  [ overlay1 ]
