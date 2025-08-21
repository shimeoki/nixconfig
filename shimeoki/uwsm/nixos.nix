{
    config,
    options,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.uwsm;

    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };

    nixos = {
        programs.uwsm.enable = true;
    };
in
{
    imports = [
        ./niri.nix
    ];

    options.shimeoki.uwsm = {
        enable = lib.mkEnableOption "uwsm" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable (
        lib.mkMerge [
            home
            nixos
        ]
    );
}
