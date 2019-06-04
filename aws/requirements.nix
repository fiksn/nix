# generated using pypi2nix tool (version: 2.0.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3.7 -e beautifulsoup4 -e boto3 -e awscli -E python37Packages.setuptools -E python37Packages.setuptools_scm -E python37Packages.setuptools-git -E python37Packages.vcversioner
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python37;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            if [ -e $out/${pkgs.python37.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python37.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ python37Packages.setuptools python37Packages.setuptools_scm python37Packages.setuptools-git python37Packages.vcversioner ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python37-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.13";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9e/a3/1d13970c3f36777c583f136c136f804d70f500168edc1edea6daa7200769/PyYAML-3.13.tar.gz";
        sha256 = "3ef3092145e9b70e3ddd2c7ad59bdd0252a94dfe3949721633e41344de00a6bf";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "awscli" = python.mkDerivation {
      name = "awscli-1.16.170";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/3e/f6/ab0953739ca19152f52b2da153158989fc79200b297ebc2c35d3f41f614c/awscli-1.16.170.tar.gz";
        sha256 = "227976b4fe4e5e4c896b14573d5e900f1cfe096e35b78f37e4c8bb56a330708a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."PyYAML"
        self."botocore"
        self."colorama"
        self."docutils"
        self."rsa"
        self."s3transfer"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://aws.amazon.com/cli/";
        license = licenses.asl20;
        description = "Universal Command Line Environment for AWS.";
      };
    };

    "beautifulsoup4" = python.mkDerivation {
      name = "beautifulsoup4-4.7.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/80/f2/f6aca7f1b209bb9a7ef069d68813b091c8c3620642b568dac4eb0e507748/beautifulsoup4-4.7.1.tar.gz";
        sha256 = "945065979fb8529dd2f37dbb58f00b661bdbcbebf954f93b32fdf5263ef35348";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."soupsieve"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.crummy.com/software/BeautifulSoup/bs4/";
        license = licenses.mit;
        description = "Screen-scraping library";
      };
    };

    "boto3" = python.mkDerivation {
      name = "boto3-1.9.160";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/31/d8/598228612d041a5d8cfbbc93c5eba9aba9267129287b14e5f375144f88c2/boto3-1.9.160.tar.gz";
        sha256 = "2ea4710257e9b451db33cc6883146be7ae2acd6bd72e77c8bc514c54766db0e3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."botocore"
        self."jmespath"
        self."s3transfer"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto3";
        license = licenses.asl20;
        description = "The AWS SDK for Python";
      };
    };

    "botocore" = python.mkDerivation {
      name = "botocore-1.12.160";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e9/a6/b88ad367a9b1ec859851a4923211debf0e850e614c103bece7d68b24d160/botocore-1.12.160.tar.gz";
        sha256 = "17b3edcee0e891d85f6d36dc25bf3e33b5d7eb55d327832904a2b12eb66150a2";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."docutils"
        self."jmespath"
        self."python-dateutil"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/botocore";
        license = licenses.asl20;
        description = "Low-level, data-driven core of boto 3.";
      };
    };

    "colorama" = python.mkDerivation {
      name = "colorama-0.3.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e6/76/257b53926889e2835355d74fec73d82662100135293e17d382e2b74d1669/colorama-0.3.9.tar.gz";
        sha256 = "48eb22f4f8461b1df5734a074b57042430fb06e1d61bd1e11b078c0fe6d7a1f1";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tartley/colorama";
        license = licenses.bsdOriginal;
        description = "Cross-platform colored terminal text.";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz";
        sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = "public domain, Python, 2-Clause BSD, GPL 3 (see COPYING.txt)";
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2c/30/f0162d3d83e398c7a3b70c91eef61d409dea205fb4dc2b47d335f429de32/jmespath-0.9.4.tar.gz";
        sha256 = "bde2aef6f44302dfb30320115b17d030798de8c4110e28d5cf6cf91a7a31074c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jmespath/jmespath.py";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/46/60/b7e32f6ff481b8a1f6c8f02b0fd9b693d1c92ddd2efb038ec050d99a7245/pyasn1-0.4.5.tar.gz";
        sha256 = "da2420fe13a9452d8ae97a0e478adde1dee153b11ba832a95b223a2ba01c10f7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/99/5b2e99737edeb28c71bcbec5b5dda19d0d9ef3ca3e92e3e925e7c0bb364c/python-dateutil-2.8.0.tar.gz";
        sha256 = "c89805f6f4d64db21ed966fda138f8a5ed7a4fdbc1a8ee329ce1b74e3c74da9e";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = "Dual License";
        description = "Extensions to the standard Python datetime module";
      };
    };

    "rsa" = python.mkDerivation {
      name = "rsa-3.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/14/89/adf8b72371e37f3ca69c6cb8ab6319d009c4a24b04a31399e5bd77d9bb57/rsa-3.4.2.tar.gz";
        sha256 = "25df4e10c263fb88b5ace923dd84bf9aa7f5019687b5e55382ffcdb8bede9db5";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pyasn1"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://stuvel.eu/rsa";
        license = "ASL 2";
        description = "Pure-Python RSA implementation";
      };
    };

    "s3transfer" = python.mkDerivation {
      name = "s3transfer-0.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/43/22/37b9aaf3969628a25b3b921612139ebc5b8dc26cabb9873c356e1ad2ce2e/s3transfer-0.2.0.tar.gz";
        sha256 = "f23d5cb7d862b104401d9021fc82e5fa0e0cf57b7660a1331425aab0c691d021";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."botocore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/s3transfer";
        license = licenses.asl20;
        description = "An Amazon S3 Transfer Manager";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz";
        sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "soupsieve" = python.mkDerivation {
      name = "soupsieve-1.9.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fb/9e/2e236603b058daa6820193d4d95f4dcfbbbd0d3c709bec8c6ef1b1902501/soupsieve-1.9.1.tar.gz";
        sha256 = "b20eff5e564529711544066d7dc0f7661df41232ae263619dede5059799cdfca";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/facelessuser/soupsieve";
        license = licenses.mit;
        description = "A modern CSS selector implementation for Beautiful Soup.";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4c/13/2386233f7ee40aa8444b47f7463338f3cbdf00c316627558784e3f542f07/urllib3-1.25.3.tar.gz";
        sha256 = "dbe59173209418ae49d485b87d1681aefa36252ee85884c31346debd19463232";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
    
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )