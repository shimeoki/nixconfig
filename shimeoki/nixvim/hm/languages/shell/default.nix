{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
        ./fmt.nix
    ];

    options.shimeoki.nixvim.languages.shell = {
        enable = lib.mkEnableOption "shell" // {
            default = languages.enable;
        };
    };
}
