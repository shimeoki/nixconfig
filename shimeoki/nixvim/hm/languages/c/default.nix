{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.c = {
        enable = lib.mkEnableOption "c" // {
            default = languages.enable;
        };
    };
}
