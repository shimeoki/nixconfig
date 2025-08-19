{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fuzzel;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.fuzzel = {
        enable = lib.mkEnableOption "fuzzel" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
