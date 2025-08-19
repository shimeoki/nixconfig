{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.zen-browser;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.zen-browser = {
        enable = lib.mkEnableOption "zen-browser" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
