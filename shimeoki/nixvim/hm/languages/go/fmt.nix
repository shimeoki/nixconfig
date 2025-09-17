{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nixvim.languages.go;
    inherit (config.shimeoki.nixvim.plugins) conform;
in
{
    config = lib.mkIf (cfg.enable && conform.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.golines ];
            plugins.conform-nvim.settings = {
                formatters_by_ft.go = [ "golines" ];
            };
        };
    };
}
