{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.kitty;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.kitty = {
        enable = lib.mkEnableOption "kitty" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
