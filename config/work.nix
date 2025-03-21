{ config, pkgs, ... }:
with pkgs;
let
colorout = rPackages.buildRPackage {
  name = "colorout";
  src = fetchFromGitHub {
    owner = "jalvesaq";
    repo = "colorout";
    rev = "ed441c5244dbf9b62f98d73c5857d3ecd6c19a41";
    sha256 = "nsWFb6CEGAhXpI8n7VQJtZW8IakSNiiH+XrzQl+ZukI=";
  };
};
tinyplot = rPackages.buildRPackage {
  name = "tinyplot";
  src = fetchFromGitHub {
    owner = "grantmcdermott";
    repo = "tinyplot";
    rev = "ad7249b2e3c8c6e76cc7fb9cb37477f229bc5807";
    sha256 = "XsxhMWok1pT29XS5q6KQ3l6l+v7p6wAg4703uKAcCEU=";
  };
};
base-R = rWrapper.override {
  packages = with rPackages; [
    collapse
    colorout
    data_table
    dplyr
    tinyplot
    httpgd
    knitr
    languageserver
    quarto
    pak
    rmarkdown
  ];
};
in
{
  home = {
    packages = with pkgs; [
      base-R
      quarto
    ];
  };
}

# vim:set et sw=2 ts=2:
