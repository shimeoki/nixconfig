{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
in
{
    imports = [
        # keep-sorted start
        ./c
        ./docker
        ./go
        ./hypr
        ./java
        ./lua
        ./markdown
        ./nix
        ./nushell
        ./python
        ./shell
        ./tex
        ./web
        # keep-sorted end
    ];

    options.shimeoki.nixvim.languages = {
        enable = lib.mkEnableOption "languages" // {
            default = nixvim.enable;
        };
    };
}
