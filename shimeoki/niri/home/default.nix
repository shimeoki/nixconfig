{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.niri;
in
{
    imports = [
        ./binds.nix
        ./layout.nix
    ];

    options.shimeoki.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.niri.settings = {
            prefer-no-csd = true;
        };
    };
}
