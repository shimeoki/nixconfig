{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
in
{
    options.shimeoki.stylix = {
        enable = lib.mkEnableOption "stylix" // {
            default = shimeoki.enable;
        };
    };
}
