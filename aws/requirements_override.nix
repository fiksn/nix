{ pkgs, python }:

with pkgs.lib;
with builtins;

self: super:

let filterValid = filterAttrs (name: value: hasAttr name super);

in filterValid {
  "mccabe" = super."mccabe".overrideDerivation
    (old: { buildInputs = old.buildInputs ++ [ self."pytest-runner" ]; });

  "py" = super."py".overrideDerivation
    (old: { buildInputs = old.buildInputs ++ [ self."setuptools-scm" ]; });

  "pytest-django" = super."pytest-django".overrideDerivation
    (old: { buildInputs = old.buildInputs ++ [ self."setuptools-scm" ]; });

  "setuptools" = super."setuptools".overrideDerivation
    (old: { pipInstallFlags = [ "--ignore-installed" ]; });

  "setuptools-scm" = super."setuptools-scm".overrideDerivation
    (old: { pipInstallFlags = [ "--ignore-installed" ]; });

  "wheel" = super."wheel".overrideDerivation
    (old: { pipInstallFlags = [ "--ignore-installed" ]; });

  "pip" = super."pip".overrideDerivation
    (old: { pipInstallFlags = [ "--ignore-installed" ]; });

  "zipp" = super."zipp".overrideDerivation
    (old: { buildInputs = old.buildInputs ++ [ self."toml" ]; });
}
