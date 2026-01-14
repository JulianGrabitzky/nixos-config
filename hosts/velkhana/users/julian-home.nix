{
  config,
  pkgs,
  lib,
  inputs,
  ...
}@args:

let
  privateConfig = import "${inputs.nixos-config-private.outPath}/velkhana.nix";
in
{
  home.username = "julian";
  home.homeDirectory = "/home/julian";

  home.packages = with pkgs; [
    btop
    brave
    bitwarden-desktop
    code-cursor
    discord
    fastfetch
    git
    ghostty
    inputs.opencode-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
    nixd
    nil
    nixpkgs-fmt
    zed-editor
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = privateConfig.programs.git.settings;
    includes = privateConfig.programs.git.includes;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    }
    // privateConfig.programs.ssh.matchBlocks."*";
  };

  home.stateVersion = "25.11";
}
