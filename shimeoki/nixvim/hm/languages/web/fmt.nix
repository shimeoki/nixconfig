{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nixvim.languages.web;
    inherit (config.shimeoki.nixvim.plugins) conform;

    fmt = [ "deno_fmt" ];
in
{
    config = lib.mkIf (cfg.enable && conform.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.deno ];
            plugins.conform-nvim.settings.formatters_by_ft = {
                javascript = fmt;
                javascriptreact = fmt;
                typescript = fmt;
                typescriptreact = fmt;
                json = fmt;
                jsonc = fmt;
                css = fmt;
                html = fmt;
                yaml = fmt;
                vue = fmt;
                markdown = fmt;
            };
        };
    };
}
