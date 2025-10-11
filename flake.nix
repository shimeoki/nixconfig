{
    description = "nixconfig";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

        flake-parts.url = "github:hercules-ci/flake-parts";
        systems.url = "github:nix-systems/x86_64-linux";

        # keep-sorted start block=yes newline_separated=yes
        dotfiles = {
            url = "github:shimeoki/dotfiles";
            inputs = {
                # keep-sorted start
                flake-parts.follows = "flake-parts";
                nixpkgs.follows = "nixpkgs";
                systems.follows = "systems";
                treefmt.follows = "treefmt";
                # keep-sorted end
            };
        };

        flake-utils = {
            url = "github:numtide/flake-utils";
            inputs = {
                systems.follows = "systems";
            };
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs = {
                # keep-sorted start
                flake-parts.follows = "flake-parts";
                nixpkgs.follows = "nixpkgs";
                pre-commit-hooks-nix.follows = "";
                # keep-sorted end
            };
        };

        niri = {
            url = "github:sodiboo/niri-flake";
            inputs = {
                # keep-sorted start
                nixpkgs-stable.follows = "nixpkgs-stable";
                nixpkgs.follows = "nixpkgs";
                # keep-sorted end
            };
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs = {
                # keep-sorted start
                flake-parts.follows = "flake-parts";
                nixpkgs.follows = "nixpkgs";
                nuschtosSearch.follows = "nuschtosSearch";
                systems.follows = "systems";
                # keep-sorted end
            };
        };

        nuschtosSearch = {
            url = "github:NuschtOS/search";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-utils.follows = "flake-utils";
            };
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs = {
                # keep-sorted start
                flake-parts.follows = "flake-parts";
                nixpkgs.follows = "nixpkgs";
                systems.follows = "systems";
                # keep-sorted end
            };
        };

        treefmt = {
            url = "github:numtide/treefmt-nix";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs = {
                # keep-sorted start
                home-manager.follows = "home-manager";
                nixpkgs.follows = "nixpkgs";
                # keep-sorted end
            };
        };
        # keep-sorted end
    };

    outputs =
        inputs:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } {
            systems = import inputs.systems;

            imports = [
                # keep-sorted start
                ./flake/fmt.nix
                ./flake/modules.nix
                ./flake/systems.nix
                # keep-sorted end
            ];
        };
}
