{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
in
{
    imports = [
        # keep-sorted start
        ./fmt.nix
        ./lint.nix
        ./lsp.nix
        # keep-sorted end
    ];

    options.shimeoki.nixvim.languages.nix = {
        enable = lib.mkEnableOption "nix" // {
            default = languages.enable;
        };
    };
}
