{
    stdenv,
    fetchzip,
    cmake,
    version,
    getSourceFromGithub ? true
}:
stdenv.mkDerivation rec {
  name = "c-blosc-${version}";

  src = if getSourceFromGithub then
    fetchzip {
        url = "https://github.com/Blosc/c-blosc/archive/v${version}.zip";
        sha256 = "195w96gl75mkxxqq6qjsmb2s1lq8z95qlc71fr5a7sckslcwglh0";
    }
  else fetchGit ./.;

  buildInputs = [ cmake ];

  phases = [ "buildPhase" "installPhase" "installCheckPhase"];

  buildPhase = ''
  ls ${src}
  cp -r ${src}/* ./
  mkdir -p build
  cd build
  '';

  installPhase= ''
  cmake -DCMAKE_INSTALL_PREFIX=$out ..
  cmake --build . --target install
  '';

  installCheckPhase = ''ctest'';
  doInstallCheck = true;

  meta = {
    description = "Blosc: A blocking, shuffling and lossless compression library";
    homepage = http://blosc.org/;
  };
}
