{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.dunst;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.dunst = {
        enable = lib.mkEnableOption "dunst" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
