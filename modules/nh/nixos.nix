{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nh;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
