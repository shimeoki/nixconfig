{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nixvim.languages.c;
    inherit (config.shimeoki.nixvim.plugins) conform;

    fmt = [ "clang-format" ];
in
{
    config = lib.mkIf (cfg.enable && conform.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.clang ];
            plugins.conform-nvim.settings = {
                formatters_by_ft = {
                    c = fmt;
                    cpp = fmt;
                };
            };
        };
    };
}
