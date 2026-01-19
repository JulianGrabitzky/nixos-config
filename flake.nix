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
      url = "github:anomalyco/opencode/upgrade-bun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixos-config-private,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # sudo nixos-rebuild switch --flake .#velkhana
        velkhana = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/velkhana/default.nix
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.julian = import ./hosts/velkhana/users/julian-home.nix;
            }
          ];
        };
      };
    };
}
