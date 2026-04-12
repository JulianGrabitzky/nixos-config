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

      # Expose the familiar docker CLI for tools that expect it.
      dockerCompat = true;

      # Let compose-managed containers resolve each other by name.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    dive
    podman-tui
  ];
}
