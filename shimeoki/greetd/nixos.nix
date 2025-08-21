{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.greetd;
in
{
    imports = [
        ./niri.nix
    ];

    options.shimeoki.greetd = {
        enable = lib.mkEnableOption "greetd" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        services.greetd = {
            enable = true;
            useTextGreeter = true;
            settings.default_session = {
                command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --remember --remember-user-session";
            };
        };
    };
}
