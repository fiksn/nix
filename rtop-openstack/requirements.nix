# generated using pypi2nix tool (version: 2.0.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3.7 -e python-cinderclient -e python-glanceclient -e python-heatclient -e python-keystoneclient -e python-neutronclient -e python-novaclient -e python-swiftclient -e python-openstackclient -E openssl -E libffi -E python37Packages.setuptools -E python37Packages.setuptools_scm -E python37Packages.setuptools-git -E python37Packages.vcversioner
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

  commonBuildInputs = with pkgs; [ openssl libffi python37Packages.setuptools python37Packages.setuptools_scm python37Packages.setuptools-git python37Packages.vcversioner ];
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
    "Babel" = python.mkDerivation {
      name = "Babel-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/be/cc/9c981b249a455fa0c76338966325fc70b7265521bad641bf2932f77712f4/Babel-2.6.0.tar.gz";
        sha256 = "8cba50f48c529ca3fa18cf81fa9403be176d374ac4d60738b839122dfaaa3d23";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };

    "PyYAML" = python.mkDerivation {
      name = "PyYAML-5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9f/2c/9417b5c774792634834e730932745bc09a7d36754ca00acf1ccd1ac2594d/PyYAML-5.1.tar.gz";
        sha256 = "436bc774ecf7c103814098159fbb84c2715d25980175292c648f2da143909f95";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/yaml/pyyaml";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "appdirs" = python.mkDerivation {
      name = "appdirs-1.4.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/48/69/d87c60746b393309ca30761f8e2b49473d43450b150cb08f3c6df5c11be5/appdirs-1.4.3.tar.gz";
        sha256 = "9e5896d1372858f8dd3344faf4e5014d21849c756c8d5701f78f8a103b372d92";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/ActiveState/appdirs";
        license = licenses.mit;
        description = "A small Python module for determining appropriate platform-specific dirs, e.g. a \"user data dir\".";
      };
    };

    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz";
        sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/d9/931a24cc5394f19383fbbe3e1147a0291276afa43a0dc3ed0d6cd9fda813/attrs-19.1.0.tar.gz";
        sha256 = "f0b870f674851ecbfbbbd364d6b5cbdff9dcedbc7f3f5e18a6891057f21fe399";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2019.3.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/06/b8/d1ea38513c22e8c906275d135818fee16ad8495985956a9b7e2bb21942a1/certifi-2019.3.9.tar.gz";
        sha256 = "b26104d6835d1f5e49452a26eb2ff87fe7090b89dfcaee5ea2212697e1e1d7ae";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.12.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/7c/27367b38e6cc3e1f49f193deb761fe75cda9f95da37b67b422e62281fcac/cffi-1.12.2.tar.gz";
        sha256 = "e113878a446c6228669144ae8a56e268c91b7f1fafae927adc4879d9849e0ea7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pycparser"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl3;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "cliff" = python.mkDerivation {
      name = "cliff-2.14.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/27/9e/bcb5e4e230a297ecbde71483f9f9e347171dc70be1352507701b203b3371/cliff-2.14.1.tar.gz";
        sha256 = "b47387a344898ccb28ca7f386f017ade9eb66dc1713e5c642a0bc09ec606cc67";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."PyYAML"
        self."cmd2"
        self."pbr"
        self."prettytable"
        self."pyparsing"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/cliff/latest/";
        license = "UNKNOWN";
        description = "Command Line Interface Formulation Framework";
      };
    };

    "cmd2" = python.mkDerivation {
      name = "cmd2-0.9.11";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e6/83/555bf188026779e74e0f8929ab039327bbaac3161f2d61804947473d03d0/cmd2-0.9.11.tar.gz";
        sha256 = "34a335b05f149d1b23e5657d597e7121b74ddf2e07d1c58f39855ade0e2a5242";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."attrs"
        self."colorama"
        self."pyperclip"
        self."wcwidth"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python-cmd2/cmd2";
        license = licenses.mit;
        description = "cmd2 - a tool for building interactive command line applications in Python";
      };
    };

    "colorama" = python.mkDerivation {
      name = "colorama-0.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/76/53/e785891dce0e2f2b9f4b4ff5bc6062a53332ed28833c7afede841f46a5db/colorama-0.4.1.tar.gz";
        sha256 = "05eed71e2e327246ad6b38c540c4a3117230b19679b875190486ddd2d721422d";
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

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.6.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/07/ca/bc827c5e55918ad223d59d299fff92f3563476c3b00d0a9157d9c0217449/cryptography-2.6.1.tar.gz";
        sha256 = "26c821cbeb683facb966045e2064303029d572a87ee69ca5a1bf54bf55f93ca6";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."asn1crypto"
        self."cffi"
        self."idna"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "debtcollector" = python.mkDerivation {
      name = "debtcollector-1.21.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/10/a4/47d2e058c612778d53a6df65f3a6802198820ac443032cc20b438df78fde/debtcollector-1.21.0.tar.gz";
        sha256 = "f6ce5a383ad73c23e1138dbb69bf45d33f4a4bdec38f02dbf2b89477ec5e55bc";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."pbr"
        self."six"
        self."wrapt"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/debtcollector/latest";
        license = "UNKNOWN";
        description = "A collection of Python deprecation patterns and strategies that help you collect your technical debt in a non-destructive manner.";
      };
    };

    "decorator" = python.mkDerivation {
      name = "decorator-4.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ba/19/1119fe7b1e49b9c8a9f154c930060f37074ea2e8f9f6558efc2eeaa417a2/decorator-4.4.0.tar.gz";
        sha256 = "86156361c50488b84a3f148056ea716ca587df2f0de1d34750d35c21312725de";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = "new BSD License";
        description = "Better living through Python with decorators";
      };
    };

    "dogpile.cache" = python.mkDerivation {
      name = "dogpile.cache-0.7.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/3e/dbf1cfc5228f1d3dca80ef714db2c5aaec5cd9efaf54d7e3daef6bc48b19/dogpile.cache-0.7.1.tar.gz";
        sha256 = "691b7f199561c4bd6e7e96f164a43cc3781b0c87bea29b7d59d859f873fd4a31";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."decorator"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/sqlalchemy/dogpile.cache";
        license = licenses.bsdOriginal;
        description = "A caching front-end based on the Dogpile lock.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz";
        sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "iso8601" = python.mkDerivation {
      name = "iso8601-0.1.12";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/45/13/3db24895497345fb44c4248c08b16da34a9eb02643cea2754b21b5ed08b0/iso8601-0.1.12.tar.gz";
        sha256 = "49c4b20e1f38aa5cf109ddcd39647ac419f928512c869dc01d5c7098eddede82";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/micktwomey/pyiso8601";
        license = licenses.mit;
        description = "Simple module to parse ISO 8601 dates";
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

    "jsonpatch" = python.mkDerivation {
      name = "jsonpatch-1.23";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9a/7d/bcf203d81939420e1aaf7478a3efce1efb8ccb4d047a33cb85d7f96d775e/jsonpatch-1.23.tar.gz";
        sha256 = "49f29cab70e9068db3b1dc6b656cbe2ee4edf7dfe9bf5a0055f17a4b6804a4b9";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."jsonpointer"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-patch";
        license = "Modified BSD License";
        description = "Apply JSON-Patches (RFC 6902) ";
      };
    };

    "jsonpointer" = python.mkDerivation {
      name = "jsonpointer-2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/52/e7/246d9ef2366d430f0ce7bdc494ea2df8b49d7a2a41ba51f5655f68cfe85f/jsonpointer-2.0.tar.gz";
        sha256 = "c192ba86648e05fdae4f08a17ec25180a9aef5008d973407b581798a83975362";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-pointer";
        license = "Modified BSD License";
        description = "Identify specific nodes in a JSON document (RFC 6901) ";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/58/b9/171dbb07e18c6346090a37f03c7e74410a1a56123f847efed59af260a298/jsonschema-2.6.0.tar.gz";
        sha256 = "6ff5f3180870836cae40f06fa10419f557208175f13ad7bc26caa77beb1f6e02";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
      };
    };

    "keystoneauth1" = python.mkDerivation {
      name = "keystoneauth1-3.13.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9c/fc/6ef3ab930af98cb7de2f26adb7083939ee78dbda0ee35677b21d41c7dc0e/keystoneauth1-3.13.1.tar.gz";
        sha256 = "ed78ed68d1915614e590be428a79c48df09f4f51acb3272b3306d7ae1a59f479";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."iso8601"
        self."os-service-types"
        self."pbr"
        self."requests"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/keystoneauth/latest/";
        license = "UNKNOWN";
        description = "Authentication Library for OpenStack Identity";
      };
    };

    "monotonic" = python.mkDerivation {
      name = "monotonic-1.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/19/c1/27f722aaaaf98786a1b338b78cf60960d9fe4849825b071f4e300da29589/monotonic-1.5.tar.gz";
        sha256 = "23953d55076df038541e648a53676fb24980f7a1be290cdda21300b3bc21dfb0";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/atdt/monotonic";
        license = "Apache";
        description = "An implementation of time.monotonic() for Python 2 & < 3.3";
      };
    };

    "msgpack" = python.mkDerivation {
      name = "msgpack-0.6.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/81/9c/0036c66234482044070836cc622266839e2412f8108849ab0bfdeaab8578/msgpack-0.6.1.tar.gz";
        sha256 = "4008c72f5ef2b7936447dcb83db41d97e9791c83221be13d5e19db0796df1972";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://msgpack.org/";
        license = licenses.asl20;
        description = "MessagePack (de)serializer.";
      };
    };

    "munch" = python.mkDerivation {
      name = "munch-2.3.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/f4/260ec98ea840757a0da09e0ed8135333d59b8dfebe9752a365b04857660a/munch-2.3.2.tar.gz";
        sha256 = "6ae3d26b837feacf732fb8aa5b842130da1daf221f5af9f9d4b2a0a6414b0d51";
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
        homepage = "http://github.com/Infinidat/munch";
        license = licenses.mit;
        description = "A dot-accessible dictionary (a la JavaScript objects).";
      };
    };

    "netaddr" = python.mkDerivation {
      name = "netaddr-0.7.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/13/7cbb180b52201c07c796243eeff4c256b053656da5cfe3916c3f5b57b3a0/netaddr-0.7.19.tar.gz";
        sha256 = "38aeec7cdd035081d3a4c306394b19d677623bf76fa0913f6695127c7753aefd";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/drkjam/netaddr/";
        license = licenses.bsdOriginal;
        description = "A network address manipulation library for Python";
      };
    };

    "netifaces" = python.mkDerivation {
      name = "netifaces-0.10.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/18/fd6e9c71a35b67a73160ec80a49da63d1eed2d2055054cc2995714949132/netifaces-0.10.9.tar.gz";
        sha256 = "2dee9ffdd16292878336a58d04a20f0ffe95555465fee7c9bd23b3490ef2abf3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/al45tair/netifaces";
        license = licenses.mit;
        description = "Portable network interface information.";
      };
    };

    "openstacksdk" = python.mkDerivation {
      name = "openstacksdk-0.27.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ed/ce/4dec1d7ed78189abc9b3d181b0ef1400abe76680f04096c9ec452254b7d7/openstacksdk-0.27.0.tar.gz";
        sha256 = "afcdc7453a9fa0265a141c5731043198e961c86fe9409258425da63aaaa7b4d9";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."PyYAML"
        self."appdirs"
        self."cryptography"
        self."decorator"
        self."dogpile.cache"
        self."iso8601"
        self."jmespath"
        self."jsonpatch"
        self."keystoneauth1"
        self."munch"
        self."netifaces"
        self."os-service-types"
        self."pbr"
        self."requestsexceptions"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://developer.openstack.org/sdks/python/openstacksdk/";
        license = "UNKNOWN";
        description = "An SDK for building applications to work with OpenStack";
      };
    };

    "os-client-config" = python.mkDerivation {
      name = "os-client-config-1.32.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/b9/6d4cad81a6d6476075ef0244485b5f9e69842166f5dadcd28bed30123789/os-client-config-1.32.0.tar.gz";
        sha256 = "6b27e93f10764f6768b11a28e8660429c3566a2aa478b879ae7b473cca0d9479";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."openstacksdk"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/os-client-config/latest";
        license = "UNKNOWN";
        description = "OpenStack Client Configuation Library";
      };
    };

    "os-service-types" = python.mkDerivation {
      name = "os-service-types-1.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/be/47/77b67f9601b3719b0a160c93e3df4c38e037b83d92f765e0efee35d3cf9f/os-service-types-1.6.0.tar.gz";
        sha256 = "b7713b21cd27fdd9d5ee6683dac507cb2c5b323decfa78bb0e21b7d3661cb8e2";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."pbr"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.openstack.org/";
        license = "UNKNOWN";
        description = "Python library for consuming OpenStack sevice-types-authority data";
      };
    };

    "osc-lib" = python.mkDerivation {
      name = "osc-lib-1.12.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/22/798d1fc700d54f36c4b43243845172354efbaf02a7bf1b87e3f200cc3877/osc-lib-1.12.1.tar.gz";
        sha256 = "26d3e32c8c4eff47240c458cddb6b75db52034d643f01de2841ad9e84904d7aa";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."cliff"
        self."keystoneauth1"
        self."openstacksdk"
        self."oslo.i18n"
        self."oslo.utils"
        self."pbr"
        self."simplejson"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/osc-lib/latest/";
        license = "UNKNOWN";
        description = "OpenStackClient Library";
      };
    };

    "oslo.config" = python.mkDerivation {
      name = "oslo.config-6.8.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/53/e5/03ee395f0d9fee8f7e55e69ee3010b9c1d359ffec29f735dd5c76ec10e1d/oslo.config-6.8.1.tar.gz";
        sha256 = "7ea34cf642df4d18f92637b58dee92c1667c141aa004ce472e257fafc278ce11";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."PyYAML"
        self."debtcollector"
        self."netaddr"
        self."oslo.i18n"
        self."requests"
        self."rfc3986"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.config/latest/";
        license = "UNKNOWN";
        description = "Oslo Configuration API";
      };
    };

    "oslo.context" = python.mkDerivation {
      name = "oslo.context-2.22.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/02/06/c31dbe6c6d1e68735a1b420cc5b9ae7ff58dd09a42171268fdc6c963be58/oslo.context-2.22.1.tar.gz";
        sha256 = "345cee82594a0237f89511c9db3ae759ef0553c278433c894509b63f7d6c3907";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."pbr"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.context/latest/";
        license = "UNKNOWN";
        description = "Oslo Context library";
      };
    };

    "oslo.i18n" = python.mkDerivation {
      name = "oslo.i18n-3.23.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/51/d8/01d9b3e17a6135cd412742cf742a3bad5366b349fccb1ef99258f1e12652/oslo.i18n-3.23.1.tar.gz";
        sha256 = "2669908357e1e49a754dc0c279512246341ae889176c568b89fd9233e65a6ae1";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."pbr"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.i18n/latest";
        license = "UNKNOWN";
        description = "Oslo i18n library";
      };
    };

    "oslo.log" = python.mkDerivation {
      name = "oslo.log-3.42.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/15/24/9fd29f00a56c41306e13a0e88e11dae5bb3c9c4f4c8ea1a7fbd67f3e0740/oslo.log-3.42.3.tar.gz";
        sha256 = "b836a6b23beb35120663d52e54312527946a613f8959d51761fed2df9d2cf55c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."monotonic"
        self."oslo.config"
        self."oslo.context"
        self."oslo.i18n"
        self."oslo.serialization"
        self."oslo.utils"
        self."pbr"
        self."pyinotify"
        self."python-dateutil"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.log/latest";
        license = "UNKNOWN";
        description = "oslo.log library";
      };
    };

    "oslo.serialization" = python.mkDerivation {
      name = "oslo.serialization-2.28.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/3d/c6/9d18210db0aca8ddb292f1fe8ad25cf7f80970e89c113af90047d5bf0d48/oslo.serialization-2.28.2.tar.gz";
        sha256 = "c3c73eb1fa45aaf4cdf3b82a0cf85497a245c7e88e803fdafa29e4315d991eb3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."msgpack"
        self."oslo.utils"
        self."pbr"
        self."pytz"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.serialization/latest/";
        license = "UNKNOWN";
        description = "Oslo Serialization library";
      };
    };

    "oslo.utils" = python.mkDerivation {
      name = "oslo.utils-3.40.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6a/be/2623aefe3766145d59b224fbc313fd15c53c5f2295b869a5cb50ab800fd0/oslo.utils-3.40.3.tar.gz";
        sha256 = "92fdd8b7f5cb079f03648015c186c8292a0a7bba918cdab32fdd1133b83280a1";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."iso8601"
        self."netaddr"
        self."netifaces"
        self."oslo.i18n"
        self."pbr"
        self."pyparsing"
        self."pytz"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/oslo.utils/latest/";
        license = "UNKNOWN";
        description = "Oslo Utility library";
      };
    };

    "pbr" = python.mkDerivation {
      name = "pbr-5.1.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/97/76/c151aa4a3054ce63bb6bbd32f3541e4ae068534ed8b74ee2687f6773b013/pbr-5.1.3.tar.gz";
        sha256 = "8c361cc353d988e4f5b998555c88098b9d5964c2e11acf7b0d21925a66bb5824";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/pbr/latest/";
        license = "UNKNOWN";
        description = "Python Build Reasonableness";
      };
    };

    "prettytable" = python.mkDerivation {
      name = "prettytable-0.7.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ef/30/4b0746848746ed5941f052479e7c23d2b56d174b82f4fd34a25e389831f5/prettytable-0.7.2.tar.bz2";
        sha256 = "853c116513625c738dc3ce1aee148b5b5757a86727e67eff6502c7ca59d43c36";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://code.google.com/p/prettytable";
        license = "BSD (3 clause)";
        description = "A simple Python library for easily displaying tabular data in a visually appealing ASCII table format";
      };
    };

    "pyOpenSSL" = python.mkDerivation {
      name = "pyOpenSSL-19.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/40/d0/8efd61531f338a89b4efa48fcf1972d870d2b67a7aea9dcf70783c8464dc/pyOpenSSL-19.0.0.tar.gz";
        sha256 = "aeca66338f6de19d1aa46ed634c3b9ae519a64b458f8468aec688e7e3c20f200";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cryptography"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pyopenssl.org/";
        license = licenses.asl20;
        description = "Python wrapper module around the OpenSSL library";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz";
        sha256 = "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pyinotify" = python.mkDerivation {
      name = "pyinotify-0.9.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e3/c0/fd5b18dde17c1249658521f69598f3252f11d9d7a980c5be8619970646e1/pyinotify-0.9.6.tar.gz";
        sha256 = "9c998a5d7606ca835065cdabc013ae6c66eb9ea76a00a1e3bc6e0cfe2b4f71f4";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/seb-m/pyinotify";
        license = licenses.mit;
        description = "Linux filesystem events monitoring";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5d/3a/24d275393f493004aeb15a1beae2b4a3043526e8b692b65b4a9341450ebe/pyparsing-2.4.0.tar.gz";
        sha256 = "1873c03321fc118f4e9746baf201ff990ceb915f433f23b395f5580d1840cb2a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pyperclip" = python.mkDerivation {
      name = "pyperclip-1.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/0f/4eda562dffd085945d57c2d9a5da745cfb5228c02bc90f2c74bbac746243/pyperclip-1.7.0.tar.gz";
        sha256 = "979325468ccf682104d5dcaf753f869868100631301d3e72f47babdea5700d1c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/asweigart/pyperclip";
        license = licenses.bsdOriginal;
        description = "A cross-platform clipboard module for Python. (Only handles plain text for now.)";
      };
    };

    "python-cinderclient" = python.mkDerivation {
      name = "python-cinderclient-4.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/44/54/ba8a5f7aefcbc2e13e5ecdd38c37d86c7bf17f73138d74461425b6fa6f30/python-cinderclient-4.1.0.tar.gz";
        sha256 = "8fb1fd1481860615730595e77ff6008a73fa516aed530825bd7cda0f221351d4";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."keystoneauth1"
        self."oslo.i18n"
        self."oslo.utils"
        self."pbr"
        self."prettytable"
        self."simplejson"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-cinderclient/latest/";
        license = "UNKNOWN";
        description = "OpenStack Block Storage API Client Library";
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

    "python-glanceclient" = python.mkDerivation {
      name = "python-glanceclient-2.16.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/56/e0/ceffe35ac9d127779a0724fec7731313990220f76ae74c11bb2bda1a4b71/python-glanceclient-2.16.0.tar.gz";
        sha256 = "3c9cc17ad1100557b3265ec9b8e88ed765dc1fa116ea58fba79ba6be315e287a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."keystoneauth1"
        self."oslo.i18n"
        self."oslo.utils"
        self."pbr"
        self."prettytable"
        self."pyOpenSSL"
        self."requests"
        self."six"
        self."warlock"
        self."wrapt"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-glanceclient/latest/";
        license = licenses.asl20;
        description = "OpenStack Image API Client Library";
      };
    };

    "python-heatclient" = python.mkDerivation {
      name = "python-heatclient-1.17.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fe/e0/1b1d4b3b93ef4eaf2318dd1242d15b80159d4d6ff2d695cda21a2c630fb9/python-heatclient-1.17.0.tar.gz";
        sha256 = "c5655079430a8e77104525cb8aea06b0ab8f22b1787ad3aae33ca4fb2662e17a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."PyYAML"
        self."cliff"
        self."iso8601"
        self."keystoneauth1"
        self."osc-lib"
        self."oslo.i18n"
        self."oslo.serialization"
        self."oslo.utils"
        self."pbr"
        self."prettytable"
        self."python-swiftclient"
        self."requests"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-heatclient/latest";
        license = "UNKNOWN";
        description = "OpenStack Orchestration API Client Library";
      };
    };

    "python-keystoneclient" = python.mkDerivation {
      name = "python-keystoneclient-3.19.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/e8/c8dc43c31efeff9df29f9a2d3990ac80742e5918c450341f899aabf35eb0/python-keystoneclient-3.19.0.tar.gz";
        sha256 = "097ac07ee4f9956cb637abee42a18094b7f916a975f53b7c8fb0d8429fd529be";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."debtcollector"
        self."keystoneauth1"
        self."oslo.config"
        self."oslo.i18n"
        self."oslo.serialization"
        self."oslo.utils"
        self."pbr"
        self."requests"
        self."six"
        self."stevedore"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-keystoneclient/latest/";
        license = "UNKNOWN";
        description = "Client Library for OpenStack Identity";
      };
    };

    "python-neutronclient" = python.mkDerivation {
      name = "python-neutronclient-6.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/51/3b/13869cbff23d04f81eabf076153eb2e84a6891b6e8d18a0cae9672327b25/python-neutronclient-6.12.0.tar.gz";
        sha256 = "450156ff761fef1a2214f38438b3abf44e6b1eb216876a107ec80ff712a3c44d";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."cliff"
        self."debtcollector"
        self."iso8601"
        self."keystoneauth1"
        self."netaddr"
        self."os-client-config"
        self."osc-lib"
        self."oslo.i18n"
        self."oslo.log"
        self."oslo.serialization"
        self."oslo.utils"
        self."pbr"
        self."python-keystoneclient"
        self."requests"
        self."simplejson"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-neutronclient/latest/";
        license = "UNKNOWN";
        description = "CLI and Client Library for OpenStack Networking";
      };
    };

    "python-novaclient" = python.mkDerivation {
      name = "python-novaclient-13.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a0/30/73345c36b76a99a78dbf9e81806c0f205f86a4c5e58a355cf4d28f5b1779/python-novaclient-13.0.0.tar.gz";
        sha256 = "559c3947b0e33713ad60a1d171435fd483910f7d66867a5358f38916eaec6f65";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."iso8601"
        self."keystoneauth1"
        self."oslo.i18n"
        self."oslo.serialization"
        self."oslo.utils"
        self."pbr"
        self."prettytable"
        self."simplejson"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-novaclient/latest";
        license = licenses.asl20;
        description = "Client library for OpenStack Compute API";
      };
    };

    "python-openstackclient" = python.mkDerivation {
      name = "python-openstackclient-3.18.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e1/13/ac8dc2eb3f606026646da29f2c79dc01f6d2b7c7bb397d6df66d6a8ff15e/python-openstackclient-3.18.0.tar.gz";
        sha256 = "33e1fde64350220d32a3a3bd976464f177de6f28fa0f11846c3f9936842ffa80";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."Babel"
        self."cliff"
        self."keystoneauth1"
        self."openstacksdk"
        self."osc-lib"
        self."oslo.i18n"
        self."oslo.utils"
        self."pbr"
        self."python-cinderclient"
        self."python-glanceclient"
        self."python-keystoneclient"
        self."python-novaclient"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-openstackclient/latest/";
        license = "UNKNOWN";
        description = "OpenStack Command-line Client";
      };
    };

    "python-swiftclient" = python.mkDerivation {
      name = "python-swiftclient-3.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c0/40/a50ec36baafa06e82d0b6ecb92dc561dc3373c1240d2202efff8b5fb8da7/python-swiftclient-3.7.0.tar.gz";
        sha256 = "1a11268a8fa2483b8b172e3bc12ce7fcef5e8790fc301c50a5f3e9dc668a7019";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."python-keystoneclient"
        self."requests"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/python-swiftclient/latest/";
        license = "UNKNOWN";
        description = "OpenStack Object Storage API Client Library";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2018.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/af/be/6c59e30e208a5f28da85751b93ec7b97e4612268bb054d0dff396e758a90/pytz-2018.9.tar.gz";
        sha256 = "d5f05e487007e29e03409f9398d074e158d920d36eb82eaf66fb1136b0c5374c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.21.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/52/2c/514e4ac25da2b08ca5a464c50463682126385c4272c18193876e91f4bc38/requests-2.21.0.tar.gz";
        sha256 = "502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."cryptography"
        self."idna"
        self."pyOpenSSL"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requestsexceptions" = python.mkDerivation {
      name = "requestsexceptions-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/ed/61b9652d3256503c99b0b8f145d9c8aa24c514caff6efc229989505937c1/requestsexceptions-1.4.0.tar.gz";
        sha256 = "b095cbc77618f066d459a02b137b020c37da9f46d9b057704019c9f77dba3065";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.openstack.org/";
        license = "UNKNOWN";
        description = "Import exceptions from potentially bundled packages in requests.";
      };
    };

    "rfc3986" = python.mkDerivation {
      name = "rfc3986-1.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e1/f0/d1571e8891e8e93ebb0fc61fb09c04acf0088bab3fa1cb02eb577e7bc135/rfc3986-1.2.0.tar.gz";
        sha256 = "bc3ae4b7cd88a99eff2d3900fcb858d44562fd7f273fc07aeef568b9bb6fc4e1";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://rfc3986.readthedocs.io";
        license = licenses.asl20;
        description = "Validating URI References per RFC 3986";
      };
    };

    "simplejson" = python.mkDerivation {
      name = "simplejson-3.16.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e3/24/c35fb1c1c315fc0fffe61ea00d3f88e85469004713dab488dee4f35b0aff/simplejson-3.16.0.tar.gz";
        sha256 = "b1f329139ba647a9548aa05fb95d046b4a677643070dc2afc05fa2e975d09ca5";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/simplejson/simplejson";
        license = licenses.mit;
        description = "Simple, fast, extensible JSON encoder/decoder for Python";
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

    "stevedore" = python.mkDerivation {
      name = "stevedore-1.30.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dc/22/a8fec083ae5214d5eb847537b1f28169136e989b56561f472dd2cbe465cd/stevedore-1.30.1.tar.gz";
        sha256 = "7be098ff53d87f23d798a7ce7ae5c31f094f3deb92ba18059b1aeb1ca9fec0a0";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      buildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."pbr"
      ];
      propagatedBuildInputs = [
        self."pbr"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/stevedore/latest/";
        license = "UNKNOWN";
        description = "Manage dynamic plugins for Python applications";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.24.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b1/53/37d82ab391393565f2f831b8eedbffd57db5a718216f82f1a8b4d381a1c1/urllib3-1.24.1.tar.gz";
        sha256 = "de9529817c93f27c8ccbfead6985011db27bd0ddfcdb2d86f3f663385c6a9c22";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."cryptography"
        self."idna"
        self."pyOpenSSL"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "warlock" = python.mkDerivation {
      name = "warlock-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/40/9f01a5e1574dab946598793351d59c86f58209d182d229aaa545abb98894/warlock-1.3.0.tar.gz";
        sha256 = "d7403f728fce67ee2f22f3d7fa09c9de0bc95c3e7bcf6005b9c1962b77976a06";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."jsonpatch"
        self."jsonschema"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/bcwaldon/warlock";
        license = "UNKNOWN";
        description = "Python object model built on JSON schema and JSON patch.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz";
        sha256 = "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wrapt" = python.mkDerivation {
      name = "wrapt-1.11.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/67/b2/0f71ca90b0ade7fad27e3d20327c996c6252a2ffe88f50a95bba7434eda9/wrapt-1.11.1.tar.gz";
        sha256 = "4aea003270831cceb8a90ff27c4031da6ead7ec1886023b80ce0dfe0adf61533";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GrahamDumpleton/wrapt";
        license = licenses.bsdOriginal;
        description = "Module for decorators, wrappers and monkey patching.";
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