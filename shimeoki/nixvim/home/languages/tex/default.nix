{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.tex = {
        enable = lib.mkEnableOption "tex" // {
            default = languages.enable;
        };
    };
}
