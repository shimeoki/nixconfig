{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) uwsm;
in
{
    imports = [
        ./niri.nix
    ];

    options.shimeoki.uwsm = {
        enable = lib.mkEnableOption "uwsm" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf uwsm.enable {
        programs.uwsm.enable = true;
    };
}
