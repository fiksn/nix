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

    sysPackages = super.lib.hiPrio (super.buildEnv {
      name = "sys-packages";
      paths = with super; [ bash bc coreutils curl dos2unix fuse_exfat gcc gdb git gnupg gosu htop jhead jq mosh netcat ngrep nmap ntp openssl pv pwgen s3fs screen sshfs tig tmux tshark unzip vim wget ];
    });

    pwnPython = super.python27.withPackages (ps: with ps; [ numpy pwntools pip ]);

    hackPackages = super.lib.hiPrio (super.buildEnv {
      name = "hack-packages";
      paths = with super; [ aircrack-ng gdb gmp jhead john metasploit nmap radare2 z3 ghidra-bin self.pwnPython arpoison ];
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
      paths = with super; [ kubectl influxdb kubernetes-helm kubectx vault redis mongodb mysql57 ];
    });
  };
in
[
  overlay1
  (import ./custom)
]

