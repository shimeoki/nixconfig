{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nixvim;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.nixvim = {
        enable = lib.mkEnableOption "nixvim" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
