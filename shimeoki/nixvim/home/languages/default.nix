{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        ./nix
        ./go
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
