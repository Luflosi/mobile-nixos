{ lib
, runCommand
, fetchgit
}:

# The minimum set of firmware files required for the device.
runCommand "pine64-pinephone-firmware" {
  src = fetchgit {
    url = "https://xff.cz/git/linux-firmware";
    rev = "0510074346983ad33b3d52ce8f5d6a8f89a564a8";
    hash = "sha256-qZVkGv4PCqKSYz92yy0+9oZY7dPW24rmj5obeaVXt0Y=";
  };
  meta.license = lib.licenses.unfreeRedistributableFirmware;
} ''
  mkdir -p "$out/lib/firmware"
  cp -vrf "$src/rtl_bt" $out/lib/firmware/
  cp -vf "$src/anx7688-fw.bin" $out/lib/firmware/
  cp -vf "$src/ov5640_af.bin" $out/lib/firmware/
''
