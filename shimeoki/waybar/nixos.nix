{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.waybar;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.waybar = {
        enable = lib.mkEnableOption "waybar" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
