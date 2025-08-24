{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.eza;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.eza = {
        enable = lib.mkEnableOption "eza" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
