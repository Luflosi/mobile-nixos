{
  mobile-nixos
, fetchFromGitLab
, ...
}:

mobile-nixos.kernel-builder {
  version = "6.13.0";
  configfile = ./config.aarch64;

  src = fetchFromGitLab {
    owner = "pine64-org";
    repo = "linux";
    rev = "ppp-6.13-20250127-1224";
    hash = "sha256-sXAG+N5i7+H0Faxf/ewb3BfeuvaJv7l1yHuEpZ2EigE=";
  };

  patches = [
    ./0001-dts-pinephone-pro-Setup-default-on-and-panic-LEDs.patch
  ];

  postInstall = ''
    echo ":: Installing FDTs"
    mkdir -p $out/dtbs/rockchip
    cp -v "$buildRoot/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb" "$out/dtbs/rockchip/"
  '';

  isModular = false;
  isCompressed = false;
}
