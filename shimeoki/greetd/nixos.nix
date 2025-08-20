{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.greetd;

    # fix: hardcoded username
    user = "d";
in
{
    options.shimeoki.greetd = {
        enable = lib.mkEnableOption "greetd" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        shimeoki.niri.enable = lib.mkForce true;
        services.greetd = {
            enable = true;
            useTextGreeter = true;
            settings = {
                # todo: uwsm integration
                initial_session = {
                    command = "niri-session";
                    inherit user;
                };

                default_session = {
                    command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --remember --remember-user-session";
                };
            };
        };
    };
}
