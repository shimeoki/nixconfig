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
  };

  outputs = { self, nixpkgs, lanzaboote, niri, home-manager, dotfiles, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit dotfiles; };
        modules = [
          ./configuration.nix
          lanzaboote.nixosModules.lanzaboote
          niri.nixosModules.niri
	  home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
