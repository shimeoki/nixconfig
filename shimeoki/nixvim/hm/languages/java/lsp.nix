{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) java;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (java.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                jdtls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "jdtls")
            ];
        };
    };
}
