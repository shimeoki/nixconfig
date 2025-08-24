{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.fastfetch;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.fastfetch = {
        enable = lib.mkEnableOption "fastfetch" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
