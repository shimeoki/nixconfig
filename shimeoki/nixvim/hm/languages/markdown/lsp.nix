{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) markdown;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (markdown.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                marksman.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "marksman")
            ];
        };
    };
}
