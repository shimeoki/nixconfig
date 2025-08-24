{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.bat;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.bat = {
        enable = lib.mkEnableOption "bat" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
