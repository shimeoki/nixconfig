{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        # keep-sorted start
        ./fmt.nix
        ./lsp.nix
        # keep-sorted end
    ];

    options.shimeoki.nixvim.languages.c = {
        enable = lib.mkEnableOption "c" // {
            default = languages.enable;
        };
    };
}
