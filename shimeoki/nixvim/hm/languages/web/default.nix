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

    options.shimeoki.nixvim.languages.web = {
        enable = lib.mkEnableOption "web" // {
            default = languages.enable;
        };
    };
}
