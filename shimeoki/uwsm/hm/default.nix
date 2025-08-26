{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) uwsm;
in
{
    options.shimeoki.uwsm = {
        enable = lib.mkEnableOption "uwsm" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf uwsm.enable {
        home.packages = [ pkgs.uwsm ];
    };
}
