{
  pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv
}:
{
  myProject = pkgs.stdenv.mkDerivation rec {
    name = "c-blosc";
    version = "1.14.4";
    buildInputs = with pkgs; [
    # (c-blosc-src {stdenv = stdenv; fetchurl = fetchurl; cmake = pkgs.cmake;})
      (callPackage ./c-blosc.nix { version = version;
                                   getSourceFromGithub = false; })
    ];
  };
}
