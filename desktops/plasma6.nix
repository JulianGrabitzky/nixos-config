{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "eu";
    variant = "";
  };
}
