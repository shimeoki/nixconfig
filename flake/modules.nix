{ inputs, ... }:
let
    mod = name: "${inputs.self}/shimeoki/${name}.nix";
in
{
    flake = {
        nixosModules = rec {
            shimeoki = mod "nixos";
            default = shimeoki;
        };

        homeModules = rec {
            shimeoki = mod "hm";
            default = shimeoki;
        };
    };
}
