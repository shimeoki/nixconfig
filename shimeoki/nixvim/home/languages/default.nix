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
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
