#
# This file represents safe opinionated defaults for a basic Phosh system.
#
# NOTE: this file and any it imports **have** to be safe to import from
#       an end-user's config.
#
{ config, lib, pkgs, options, ... }:

{
  mobile.beautification = {
    silentBoot = lib.mkDefault true;
    splash = lib.mkDefault true;
  };

  services.desktopManager.phosh = {
    enable = true;
    group = "users";
  };

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    # Disabled since it uses `olm` which was marked insecure.
    #chatty              # IM and SMS
    epiphany            # Web browser
    gnome-console       # Terminal
    megapixels          # Camera
  ];

  hardware.sensor.iio.enable = true;

  assertions = [
    { assertion = options.services.desktopManager.phosh.user.isDefined;
    message = ''
      `services.desktopManager.phosh.user` not set.
        When importing the phosh configuration in your system, you need to set `services.desktopManager.phosh.user` to the username of the session user.
    '';
    }
  ];
}
