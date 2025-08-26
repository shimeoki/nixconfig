{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.hypr = {
        enable = lib.mkEnableOption "hypr" // {
            default = languages.enable;
        };
    };
}
