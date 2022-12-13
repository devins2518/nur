{ stdenv, fetchurl, lib }:

let
  os = if stdenv.isLinux then "linux" else "macos";
  arch = if stdenv.isx86_64 then "x86_64" else "aarch64";
  v = "0.11.0-dev.740+4d2372139";
  shas = {
    x86_64-linux =
      "bd83ec901811539918d7336303a5b6e02440f8a3e9ca20eec51188aaa50155e1";
    aarch64-linux =
      "72e8f2014cb4b7b8ab970fc292cb759f58426a118de4ab10c1b8a8ee1979a79b";
    x86_64-darwin =
      "8ba0fb335f8e013c6a939596b5f5f43ce451668e38079c50ba58bf4465116a91";
    aarch64-darwin =
      "0ad66fdf578ae2a8f54025c69d1f92a0f2fa661f99cb983a9dbe10cc5a6c85bc";
  };
in stdenv.mkDerivation rec {
  pname = "zig-master";
  version = "unstable-2022-12-13";

  src = fetchurl {
    url = "https://ziglang.org/builds/zig-${os}-${arch}-${v}.tar.xz";
    sha256 = shas.${stdenv.hostPlatform.system};
  };

  installPhase = ''
    install -D zig "$out/bin/zig"
    install -D LICENSE "$out/usr/share/licenses/zig/LICENSE"
    cp -r lib "$out/lib"
    install -d "$out/usr/share/doc"
    cp -r doc "$out/usr/share/doc/zig"
  '';

  meta = with lib; {
    description =
      "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.";
    homepage = "https://github.com/ziglang/zig";
    maintainers = with maintainers; [ devins2518 ];
    platforms = with platforms; linux ++ darwin;
  };
}
