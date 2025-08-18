{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.python = {
        enable = lib.mkEnableOption "python" // {
            default = languages.enable;
        };
    };
}
