{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) languages;
    cfg = languages.go;
in
{
    imports = [
        ./lsp.nix
    ];

    options.shimeoki.nixvim.languages.go = {
        enable = lib.mkEnableOption "go" // {
            default = languages.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.dependencies = {
            go.enable = true;
        };
    };
}
