{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.docker;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            dockerls.enable = true;
        };
    };
}
