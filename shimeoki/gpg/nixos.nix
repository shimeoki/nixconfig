{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.gpg;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
