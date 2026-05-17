{
  pkgs,
  inputs,
  unstable,
  ...
}:

let
  privateConfig = import "${inputs.nixos-config-private.outPath}/velkhana.nix";
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  home.username = "julian";
  home.homeDirectory = "/home/julian";

  home.packages = with pkgs; [
    brave
    bitwarden-desktop
    bun
    code-cursor
    discord
    fastfetch
    firefox
    freecad
    git
    unstable.gemini-cli
    ghostty
    unstable.codex
    logseq
    nixd
    nil
    nixpkgs-fmt
    unstable.opencode
    obsidian
    openfortivpn
    openscad
    pciutils
    prusa-slicer
    ripgrep
    usbutils
    zed-editor
  ];

  services.flatpak = {
    packages = [ "com.bambulab.BambuStudio" ];
  };

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

  # Keep this aligned with the Home Manager release in flake.nix.
  home.stateVersion = "25.11";
}
