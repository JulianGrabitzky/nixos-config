{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  # Niri creates its editable default config on the first login.
  # These provide the applications used by its default shortcuts and startup.
  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    waybar
    swaylock
    xwayland-satellite
    brightnessctl
    playerctl
  ];

  environment.sessionVariables.XKB_DEFAULT_LAYOUT = config.services.xserver.xkb.layout;
  security.pam.services.swaylock = { };

  # Start notifications only while the Niri session is running.
  systemd.user.services.mako = {
    description = "Niri notification daemon";
    partOf = [ "niri.service" ];
    after = [ "niri.service" ];
    wantedBy = [ "niri.service" ];
    serviceConfig.ExecStart = "${pkgs.mako}/bin/mako";
  };
}
