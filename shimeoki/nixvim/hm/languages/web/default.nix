{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
        ./fmt.nix
    ];

    options.shimeoki.nixvim.languages.web = {
        enable = lib.mkEnableOption "web" // {
            default = languages.enable;
        };
    };
}
