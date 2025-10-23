{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) docker;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (docker.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                dockerls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "dockerls")
            ];
        };
    };
}
