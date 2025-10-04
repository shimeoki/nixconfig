{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) materialgram;
in
{
    options.shimeoki.materialgram = {
        enable = lib.mkEnableOption "materialgram" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf materialgram.enable {
        home.packages = [ pkgs.materialgram ];
    };
}
