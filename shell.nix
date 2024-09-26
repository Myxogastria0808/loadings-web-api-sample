let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/658e7223191d2598641d50ee4e898126768fe847.tar.gz") {};

  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages)
      loadings
      plumber
      languageserver;
  };
  system_packages = builtins.attrValues {
    inherit (pkgs)
      httpie
      glibcLocales
      nix
      R;
  };
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";
  buildInputs = [  rpkgs  system_packages   ];
}