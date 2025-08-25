{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.carapace;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.carapace = {
        enable = lib.mkEnableOption "carapace" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
