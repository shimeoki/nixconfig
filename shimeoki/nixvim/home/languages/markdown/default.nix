{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.markdown = {
        enable = lib.mkEnableOption "markdown" // {
            default = languages.enable;
        };
    };
}
