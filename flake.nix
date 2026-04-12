{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-config-private = {
      url = "git+ssh://git@github.com/JulianGrabitzky/nixos-config-private.git";
      flake = false;
    };
    opencode-flake = {
      url = "github:anomalyco/opencode?tag=v1.2.26";
      # Opencode needs bun 1.3.9
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # Each host owns its own system and Home Manager wiring.
        velkhana = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/velkhana/default.nix
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
