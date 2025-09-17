{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        ./c
        ./docker
        ./go
        ./hypr
        ./lua
        ./markdown
        ./nix
        ./nushell
        ./python
        ./shell
        ./tex
        ./web
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
