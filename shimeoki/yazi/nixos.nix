{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.yazi;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.yazi = {
        enable = lib.mkEnableOption "yazi" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
