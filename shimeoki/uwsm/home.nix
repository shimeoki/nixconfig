{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.uwsm;
in
{
    options.shimeoki.uwsm = {
        enable = lib.mkEnableOption "uwsm" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        home.packages = [ pkgs.uwsm ];
    };
}
