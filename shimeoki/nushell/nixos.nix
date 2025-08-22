{
    config,
    options,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nushell;

    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home ];
    };

    nixos = {
        # set as default shell. maybe add as an option?
        users.users.d.shell = pkgs.nushell; # fix: hardcoded username
    };
in
{
    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
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
