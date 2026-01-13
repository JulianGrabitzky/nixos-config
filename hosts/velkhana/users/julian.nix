{ pkgs, ... }:

{
  users.users.julian = {
    isNormalUser = true;
    description = "julian";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
}
