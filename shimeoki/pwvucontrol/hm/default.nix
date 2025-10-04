{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) pwvucontrol;
in
{
    options.shimeoki.pwvucontrol = {
        enable = lib.mkEnableOption "pwvucontrol" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf pwvucontrol.enable {
        home.packages = [ pkgs.pwvucontrol ];
    };
}
