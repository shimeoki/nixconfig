{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.markdown;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            marksman.enable = true;
        };
    };
}
