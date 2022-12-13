{ stdenv, fetchFromGitHub, lib, pkgs, system ? builtins.currentSystem, }:

let
  zig-overlay = pkgs.fetchFromGitHub {
    owner = "mitchellh";
    repo = "zig-overlay";
    rev = "78cf6e432a7152acb28ca91ed74df0330ff9b756";
    sha256 = "sha256-OnErjMYcPunIavTLWTHo19PpdB3RBvRYeDeZ9k7resw=";
  };
  zig = (import zig-overlay { inherit pkgs system; }).default;
in stdenv.mkDerivation rec {
  name = "gyro";
  version = "unstable-2022-12-13";

  src = fetchFromGitHub {
    owner = "mattnite";
    repo = "gyro";
    rev = "30cdca545b7ee96124fdfdcf0a490913875fb87c";
    sha256 = "sha256-7X2c0kmEGuHTMrUFNIFd0jSBDdfb51+0FFzy8hQpo8g=";
  };

  nativeBuildInputs = [ zig ];

  preBuild = ''
    export HOME=$TMPDIR
  '';

  installPhase = ''
    zig build -Drelease-safe --prefix $out
  '';

  meta = with lib; {
    description = "A Zig package manager";
    homepage = "https://github.com/devins2518/gyro-nix";
    license = licenses.mit;
    maintainers = with maintainers; [ devins2518 ];
    platforms = with platforms; linux ++ darwin;
  };
}
