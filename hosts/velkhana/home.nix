{
  pkgs,
  inputs,
  unstable,
  ...
}:

let
  privateConfig = import "${inputs.nixos-config-private.outPath}/velkhana.nix";
  llmAgents = inputs.llm-agents-nix.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  home.username = "julian";
  home.homeDirectory = "/home/julian";
  home.sessionVariables.SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/ssh-agent";

  home.packages = with pkgs; [
    anki
    brave
    bitwarden-desktop
    bun
    discord
    fastfetch
    firefox
    freecad
    git
    git-xet
    ghostty
    llmAgents.codex
    nixd
    nil
    nixpkgs-fmt
    llmAgents.opencode
    obsidian
    openfortivpn
    openscad
    pciutils
    ripgrep
    usbutils
    inputs.t3code-nix.packages.${system}.t3code
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

  programs.bash = {
    enable = true;
    initExtra = ''
      export SSH_AUTH_SOCK="''${XDG_RUNTIME_DIR}/ssh-agent"
    '';
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = privateConfig.programs.ssh.settings // {
      "*" = (privateConfig.programs.ssh.settings."*" or { }) // {
        addKeysToAgent = "yes";
      };
    };
  };

  # Keep this aligned with the Home Manager release in flake.nix.
  home.stateVersion = "26.05";
}
