{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.go;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            gopls = {
                enable = true;
                settings.gopls = {
                    hints = {
                        rangeVariableTypes = true;
                        parameterNames = true;
                        constantValues = true;
                        assignVariableTypes = true;
                        compositeLiteralFields = true;
                        compositeLiteralTypes = true;
                        functionTypeParameters = true;
                    };
                };
            };
        };
    };
}
