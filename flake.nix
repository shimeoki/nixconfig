{
    description = "nixconfig";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri = {
            url = "github:/sodiboo/niri-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        dotfiles = {
            url = "github:shimeoki/dotfiles";
            flake = false;
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:/nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        { self, nixpkgs, ... }@inputs:
        {
            nixosModules.shimeoki = ./shimeoki;
            nixosConfigurations = {
                nixos = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    specialArgs = { inherit inputs; };
                    modules = [
                        self.nixosModules.shimeoki
                        ./configuration.nix
                        inputs.lanzaboote.nixosModules.lanzaboote
                        inputs.niri.nixosModules.niri
                        inputs.home-manager.nixosModules.home-manager
                        inputs.stylix.nixosModules.stylix
                    ];
                };
            };
        };
}
