{ config, lib, pkgs, ... }:

{
  mobile.kernel.structuredConfig = [
    (helpers: with helpers; {
      # Keyboard
      IP5XXX_POWER = yes;
      KEYBOARD_PINEPHONE = yes;
    })
  ];
}
