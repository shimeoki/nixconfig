{
    description = "nixconfig";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

        flake-parts.url = "github:hercules-ci/flake-parts";
        systems.url = "github:nix-systems/x86_64-linux";

        flake-compat = {
            url = "github:edolstra/flake-compat";
            flake = false;
        };

        dotfiles = {
            url = "github:shimeoki/dotfiles";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                systems.follows = "systems";
            };
        };

        git-hooks = {
            url = "github:cachix/git-hooks.nix";
            inputs = {
                nixpkgs.follows = "nixpkgs";
                flake-compat.follows = "flake-compat";
            };
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
                flake-compat.follows = "flake-compat";
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
        {
            self,
            nixpkgs,
            systems,
            git-hooks,
            ...
        }@inputs:
        let
            forEachSystem = nixpkgs.lib.genAttrs (import systems);
            getPkgs = system: import nixpkgs { inherit system; };

            mkSystem =
                system: modules:
                nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = { inherit inputs; };
                    modules = modules ++ [ { nixpkgs.hostPlatform = system; } ];
                };

            mkHooks =
                system:
                git-hooks.lib.${system}.run {
                    src = ./.;
                    hooks = {
                        nixfmt-rfc-style = {
                            enable = true;
                            settings.width = 80;
                            args = [ "--indent=4" ];
                        };
                    };
                };

            mkFormatter =
                system:
                let
                    pkgs = getPkgs system;
                    hooks = mkHooks system;
                    inherit (hooks.config) package configFile;

                    script = ''
                        ${package}/bin/pre-commit run --all-files \
                            --config ${configFile}
                    '';
                in
                pkgs.writeShellScriptBin "shimeoki-nixconfig-fmt" script;

            mkDevShell =
                system:
                let
                    pkgs = getPkgs system;
                    hooks = mkHooks system;
                    inherit (hooks) shellHook enabledPackages;
                in
                pkgs.mkShell {
                    packages = with pkgs; [
                        nushell
                    ];

                    buildInputs = enabledPackages;

                    shellHook = shellHook + ''
                        exec nu
                    '';
                };
        in
        {
            nixosModules.shimeoki = ./shimeoki/nixos.nix;
            nixosModules.default = self.nixosModules.shimeoki;

            homeModules.shimeoki = ./shimeoki/hm.nix;
            homeModules.default = self.homeModules.shimeoki;

            formatter = forEachSystem mkFormatter;

            checks = forEachSystem (system: {
                pre-commit = mkHooks system;
            });

            devShells = forEachSystem (system: {
                default = mkDevShell system;
            });

            nixosConfigurations = {
                yuki = mkSystem "x86_64-linux" [
                    ./hosts/yuki
                    ./users/d
                ];
            };
        };
}
