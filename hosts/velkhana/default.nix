{
  inputs,
  pkgs,
  system,
  unstable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/default.nix

    ../../services/podman.nix
    ../../services/btop.nix
    ../../services/bluetooth.nix
    ../../services/printing.nix
    ../../services/sound.nix
    ../../services/power-thermal.nix
    ../../services/fwupd.nix
    ../../services/localsend.nix

    ../../desktops/plasma6.nix
  ];

  programs.nix-ld.enable = true;

  users.users.julian = {
    isNormalUser = true;
    description = "julian";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs system;
    inherit unstable;
  };
  home-manager.users.julian = import ./home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-c2511787-cc49-4a3e-817c-435b40cdbc73".device =
    "/dev/disk/by-uuid/c2511787-cc49-4a3e-817c-435b40cdbc73";

  networking.hostName = "velkhana";
  networking.networkmanager.enable = true;

  services.flatpak.enable = true;

  system.stateVersion = "26.05";
}
