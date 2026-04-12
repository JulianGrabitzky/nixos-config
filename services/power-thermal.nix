{ pkgs, ... }:
{
  # Framework AMD laptops work better with power-profiles-daemon than TLP.
  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    powertop
  ];
}
