{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.lazygit;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };
in
{
    options.shimeoki.lazygit = {
        enable = lib.mkEnableOption "lazygit" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
