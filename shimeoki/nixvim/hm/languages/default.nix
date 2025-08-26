{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        ./nix
        ./go
        ./c
        ./nushell
        ./lua
        ./css
        ./markdown
        ./python
        ./shell
        ./tex
        ./hypr
        ./docker
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
