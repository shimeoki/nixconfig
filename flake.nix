{
    description = "nixconfig";

    inputs = {
        # maybe better not to follow?

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

        flake-parts.url = "github:hercules-ci/flake-parts";
        systems.url = "github:nix-systems/x86_64-linux";

        dotfiles = {
            url = "github:shimeoki/dotfiles";
            flake = false;
        };

        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs.systems.follows = "systems";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-parts.follows = "flake-parts";
                pre-commit-hooks-nix.follows = "";
            };
        };

        niri = {
            url = "github:sodiboo/niri-flake";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                nixpkgs-stable.follows = "nixpkgs-stable";
            };
        };

        nuschtosSearch = {
            url = "github:NuschtOS/search";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-utils.follows = "flake-utils";
            };
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-parts.follows = "flake-parts";
                systems.follows = "systems";
                nuschtosSearch.follows = "nuschtosSearch";
            };
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                home-manager.follows = "home-manager";
            };
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-parts.follows = "flake-parts";
                systems.follows = "systems";
            };
        };
    };

    outputs =
        { self, nixpkgs, ... }@inputs:
        {
            nixosModules.shimeoki = ./shimeoki;
            nixosConfigurations = {
                yuki = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    specialArgs = { inherit inputs; };
                    modules = [
                        self.nixosModules.shimeoki
                        ./hosts/yuki
                        inputs.lanzaboote.nixosModules.lanzaboote
                        inputs.home-manager.nixosModules.home-manager
                        inputs.stylix.nixosModules.stylix
                    ];
                };
            };
        };
}
