{ pkgs, ... }:

let
  powerprofilesctl = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";
in

{
  # Framework AMD laptops work better with power-profiles-daemon than TLP.
  services.power-profiles-daemon.enable = true;

  # Start in the quietest profile, but keep Plasma's GUI power mode switching.
  systemd.services.power-profile-default = {
    description = "Set the default power profile";
    wantedBy = [ "multi-user.target" ];
    after = [
      "dbus.service"
      "power-profiles-daemon.service"
    ];
    wants = [ "power-profiles-daemon.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      # Change this to `--disable` later if you do not want AC/battery events to switch profiles.
      ${powerprofilesctl} configure-battery-aware --enable
      ${powerprofilesctl} set power-saver
    '';
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    powertop
  ];
}
