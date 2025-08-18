{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.lsp;
in
{
    options.shimeoki.nixvim.plugins.lsp = {
        enable = lib.mkEnableOption "lsp" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            plugins.lspconfig.enable = true;
            lsp.inlayHints.enable = true;
        };
    };
}
