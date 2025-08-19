{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.lua = {
        enable = lib.mkEnableOption "lua" // {
            default = languages.enable;
        };
    };
}
