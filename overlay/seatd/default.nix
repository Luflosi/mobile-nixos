{
  prev_seatd,
  fetchFromSourcehut,
}:
prev_seatd.overrideAttrs (old: rec {
  version = "0.8.0";
  src = fetchFromSourcehut {
    owner = "~kennylevinsen";
    repo = "seatd";
    rev = version;
    hash = "sha256-YaR4VuY+wrzbnhER4bkwdm0rTY1OVMtixdDEhu7Lnws=";
  };
})
