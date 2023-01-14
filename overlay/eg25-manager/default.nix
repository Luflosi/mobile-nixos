{ lib
, stdenv
, fetchFromGitLab
, gnugrep
, meson
, ninja
, pkg-config
, scdoc
, curl
, glib
, libgpiod
, libgudev
, libusb1
, modemmanager
}:

stdenv.mkDerivation rec {
  pname = "eg25-manager";
  version = "0.4.6";

  src = fetchFromGitLab {
    owner = "mobian1";
    repo = pname;
    rev = version;
    hash = "sha256-2JsdwK1ZOr7ljNHyuUMzVCpl+HV0C5sA5LAOkmELqag=";
  };

  postPatch = ''
    substituteInPlace 'udev/80-modem-eg25.rules' \
      --replace '/bin/grep' '${gnugrep}/bin/grep'
  '';

  depsBuildBuild = [
    pkg-config
  ];

  nativeBuildInputs = [
    glib # Contains gdbus-codegen program
    meson
    ninja
    pkg-config
    scdoc
  ];

  buildInputs = [
    curl
    glib
    libgpiod
    libgudev
    libusb1
    modemmanager
  ];

  meta = with lib; {
    description = "Manager daemon for the Quectel EG25 mobile broadband modem";
    homepage = "https://gitlab.com/mobian1/eg25-manager";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ Luflosi ];
    platforms = platforms.linux;
  };
}
