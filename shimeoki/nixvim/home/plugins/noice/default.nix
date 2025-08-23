{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.noice;
in
{
    imports = [
        ./routes.nix
        ./views.nix
        ./lsp.nix
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.noice = {
        enable = lib.mkEnableOption "noice" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        shimeoki.nixvim.plugins.notify.enable = lib.mkForce true;
        programs.nixvim.plugins.noice.enable = true;
    };
}
