{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.niri;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
    enable = {
        programs.niri.enable = true;
    };
in
{
    options.shimeoki.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (
        lib.mkMerge [
            home
            enable
        ]
    );
}
