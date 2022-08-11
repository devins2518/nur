{ stdenv, fetchurl, lib }:

let
  os = if stdenv.isLinux then "linux" else "macos";
  arch = if stdenv.isx86_64 then "x86_64" else "aarch64";
  v = "0.10.0-dev.3513+e218b7ea0";
  shas = {
    x86_64-linux =
      "3b4ac3c1acda20ad28e9edc8c2b73a11090aba4c06b4eeab0ab8cc99e3e1a1d9";
    aarch64-linux =
      "b42cb3b89ad4e67398c3df04360eb363fa318c1b9b9944e850db07a2632d9dd3";
    x86_64-darwin =
      "3b2b6f04d95764a337f2764756045d7cc1375d18954946a50da500a05b85e053";
    aarch64-darwin =
      "cfb976a6a2601149d5ea1ee4cc9b1134f8ea518985cfbcfb9828d495b0d48266";
  };
in stdenv.mkDerivation rec {
  pname = "zig-master";
  version = "unstable-2022-08-10";

  src = fetchurl {
    url = "https://ziglang.org/builds/zig-${os}-${arch}-${v}.tar.xz";
    sha256 = shas.${stdenv.hostPlatform.system};
  };

  installPhase = ''
    install -D zig "$out/bin/zig"
    install -D LICENSE "$out/usr/share/licenses/zig/LICENSE"
    cp -r lib "$out/lib"
    install -d "$out/usr/share/doc"
    cp -r docs "$out/usr/share/doc/zig"
  '';

  meta = with lib; {
    description =
      "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.";
    homepage = "https://github.com/ziglang/zig";
    maintainers = with maintainers; [ devins2518 ];
    platforms = with platforms; linux ++ darwin;
  };
}
