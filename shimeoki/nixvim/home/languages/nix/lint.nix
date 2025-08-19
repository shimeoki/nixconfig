{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nixvim.languages.nix;
    inherit (config.shimeoki.nixvim.plugins) lint;
in
{
    config = lib.mkIf (cfg.enable && lint.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.statix ];
            plugins.lint.lintersByFt.nix = [ "statix" ];
        };
    };
}
