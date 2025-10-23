{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.nix;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            nixd = {
                enable = true;
                config = {
                    cmd = [ "nixd" ];
                    filetypes = [ "nix" ];
                    root_markers = [
                        "flake.nix"
                        ".git"
                    ];
                };
            };
        };
    };
}
