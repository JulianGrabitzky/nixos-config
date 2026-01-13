{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = [
    pkgs.kitty # required for the default Hyprland config
  ];
}
