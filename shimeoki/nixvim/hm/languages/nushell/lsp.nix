{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) nushell;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (nushell.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                nushell.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "nushell")
            ];
        };
    };
}
