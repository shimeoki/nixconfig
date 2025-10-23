{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim) lspconfig languages plugins;
    inherit (languages) lua;
    inherit (plugins) lsp;
in
{
    config = lib.mkIf (lua.enable && lsp.enable) {
        programs.nixvim = {
            lsp.servers = {
                lua_ls.enable = true;
            };

            extraFiles = lib.mkMerge [
                (lspconfig "lua_ls")
            ];
        };
    };
}
