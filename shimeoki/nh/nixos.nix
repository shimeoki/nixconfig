{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nh;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
