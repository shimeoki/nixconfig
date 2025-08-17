{
    config,
    options,
    lib,
    ...
}:
let
    cfg = config.shimeoki.gpg;
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    options.shimeoki.gpg = {
        enable = lib.mkEnableOption "gpg" // {
            default = true;
        };
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [ home ]);
}
