{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.docker = {
        enable = lib.mkEnableOption "docker" // {
            default = languages.enable;
        };
    };
}
