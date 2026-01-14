{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/default.nix
    ../../modules/nix-ld.nix
    ./users/julian.nix

    ../../services/podman.nix
    ../../services/tailscale.nix
    ../../services/ssh.nix
    ../../services/printing.nix
    ../../services/sound.nix
    ../../services/fwupd.nix

    ../../desktops/plasma6.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices."luks-c2511787-cc49-4a3e-817c-435b40cdbc73".device =
    "/dev/disk/by-uuid/c2511787-cc49-4a3e-817c-435b40cdbc73";

  networking.hostName = "velkhana";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
}
