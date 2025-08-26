{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = languages.enable;
        };
    };
}
