{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) tex;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (tex.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                texlab.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "texlab")
            ];
        };
    };
}
