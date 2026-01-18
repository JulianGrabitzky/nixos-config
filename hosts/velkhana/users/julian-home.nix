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
    brave
    bitwarden-desktop
    code-cursor
    discord
    fastfetch
    git
    ghostty
    inputs.opencode-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
    logseq
    nixd
    nil
    nixpkgs-fmt
    zed-editor
    openfortivpn
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
  services.ssh-agent.enableBashIntegration = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"
    '';
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = privateConfig.programs.ssh.matchBlocks // {
      "*" = (privateConfig.programs.ssh.matchBlocks."*" or { }) // {
        addKeysToAgent = "yes";
      };
    };
  };

  home.stateVersion = "25.11";
}
