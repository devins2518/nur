{ stdenv, pkgs, lib, zig }:

stdenv.mkDerivation rec {
  name = "gyro";
  version = "unstable-2021-09-26";

  src = fetchTarball {
    url =
      "https://github.com/mattnite/gyro/releases/download/0.3.0/gyro-0.3.0-linux-x86_64.tar.gz";
    sha256 = "sha256:0p1n33qz0rrz625ma7wbj6hhjzghk44zq829crhw7l5zgz1r7frb";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod +x gyro
    install gyro $out/bin
  '';

  meta = with lib; {
    description = "A Zig package manager";
    homepage = "https://github.com/devins2518/gyro-nix";
    license = licenses.mit;
    maintainers = with maintainers; [ devins2518 ];
    platforms = platforms.linux;
  };
}
