{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Plasma uses Bluedevil for native Bluetooth settings and tray integration.
  environment.systemPackages = with pkgs; [
    kdePackages.bluedevil
  ];
}
