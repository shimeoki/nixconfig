{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nushell;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
