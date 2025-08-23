{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.conform;
in
{
    imports = [
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.conform = {
        enable = lib.mkEnableOption "conform" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.conform-nvim = {
            enable = true;
            settings = {
                format_on_save = ''
                    function(bufnr)
                        if vim.g.disable_format or vim.b[bufnr].disable_format then
                            return
                        end

                        return { timeout_ms = 500, lsp_format = "fallback" }
                    end
                '';
            };
        };
    };
}
