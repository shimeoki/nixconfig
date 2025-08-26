{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.css = {
        enable = lib.mkEnableOption "css" // {
            default = languages.enable;
        };
    };
}
