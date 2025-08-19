{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.languages.python;
    inherit (config.shimeoki.nixvim.plugins) lsp;
in
{
    config = lib.mkIf (cfg.enable && lsp.enable) {
        programs.nixvim.lsp.servers = {
            jedi_language_server.enable = true;
            # fix: imports, but doesn't launch
            ruff = {
                enable = true;
                settings = {
                    init_options.settings = {
                        lineLength = 80;
                        lint = {
                            select = [
                                "E4"
                                "E7"
                                "E9"
                                "F"
                            ];
                        };
                    };
                    on_attach = ''
                        -- disable hover for ruff
                        client.server_capabilities.hoverProvider = false
                    '';
                };
            };
        };
    };
}
