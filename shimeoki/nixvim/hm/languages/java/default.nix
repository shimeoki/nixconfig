{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.java = {
        enable = lib.mkEnableOption "java" // {
            default = languages.enable;
        };
    };
}
