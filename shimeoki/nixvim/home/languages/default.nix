{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        ./nix
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
