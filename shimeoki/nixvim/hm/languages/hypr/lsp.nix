{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) hypr;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (hypr.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                hyprls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "hyprls")
            ];
        };
    };
}
