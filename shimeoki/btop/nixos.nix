{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.btop;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.btop = {
        enable = lib.mkEnableOption "btop" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
