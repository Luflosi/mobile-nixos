{
stdenv
, lib
, fetchFromGitHub
, autoreconfHook
, pkg-config

, android-headers
, file
, useLegacyProperties ? false
}:

let
  inherit (stdenv) targetPlatform buildPlatform;
  libPrefix = if targetPlatform == buildPlatform then ""
    else stdenv.targetPlatform.config;
in
stdenv.mkDerivation {
  pname = "libhybris";
  version = "0-unstable-2024-11-07";

  src = fetchFromGitHub {
    owner = "libhybris";
    repo = "libhybris";
    rev = "9f61f26c44d9a3bf62efb67d4c32a7a0c89c21ca";
    hash = "";
  };

  patches = [
    ./0001-Removes-failing-test-for-wayland-less-builds.patch
  ]
    ++ lib.optional useLegacyProperties ./0001-HACK-Rely-on-legacy-properties-rather-than-native-pr.patch
  ;

  postAutoreconf = ''
    substituteInPlace configure \
      --replace "/usr/bin/file" "${file}/bin/file"
  '';

  NIX_LDFLAGS = [
    # For libsupc++.a
    "-L${stdenv.cc.cc.out}/${libPrefix}/lib/"
  ];

  configureFlags = [
    "--with-android-headers=${android-headers}/include/android/"
  ]
  ++ lib.optional targetPlatform.isAarch64 "--enable-arch=arm64"
  ++ lib.optional targetPlatform.isAarch32 "--enable-arch=arm"
  ;

  sourceRoot = "source/hybris";

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];
}
