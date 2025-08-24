{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fd;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.fd = {
        enable = lib.mkEnableOption "fd" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
