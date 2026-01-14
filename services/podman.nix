{ pkgs, ... }:

{
  virtualisation = {
    containers = {
      enable = true;
      containersConf.settings = {
        engine.compose_warning_logs = false;
      };
    };
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    dive
    podman-tui
  ];
}
