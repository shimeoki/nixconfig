{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.tex;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            texlab.enable = true;
        };
    };
}
