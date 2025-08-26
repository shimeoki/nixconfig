{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.uwsm;
in
{
    imports = [
        ./niri.nix
    ];

    options.shimeoki.uwsm = {
        enable = lib.mkEnableOption "uwsm" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.uwsm.enable = true;
    };
}
