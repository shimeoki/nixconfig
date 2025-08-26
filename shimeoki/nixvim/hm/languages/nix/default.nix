{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        ./lsp.nix
        ./fmt.nix
        ./lint.nix
    ];

    options.shimeoki.nixvim.languages.nix = {
        enable = lib.mkEnableOption "nix" // {
            default = languages.enable;
        };
    };
}
