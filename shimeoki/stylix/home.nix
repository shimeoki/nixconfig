{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
in
{
    options.shimeoki.stylix = {
        enable = lib.mkEnableOption "stylix" // {
            default = module.enable;
        };
    };
}
