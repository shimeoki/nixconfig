{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) swww;
in
{
    options.shimeoki.swww = {
        enable = lib.mkEnableOption "swww" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf swww.enable {
        services.swww.enable = true;

        home.sessionVariables = {
            SWWW_TRANSITION = "any";
        };
    };
}
