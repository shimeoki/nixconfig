{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.greetd;
    inherit (module) niri uwsm;

    # fix: hardcoded username
    user = "d";

    exec = "/run/current-system/sw/bin/niri-session";
    command =
        if niri.enable then
            if uwsm.enable then "uwsm start -F ${exec}" else exec
        else
            "/usr/bin/env bash"; # todo: use login shell
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
                initial_session = {
                    inherit command user;
                };

                default_session = {
                    command = "${pkgs.tuigreet}/bin/tuigreet --user-menu --time --asterisks --remember --remember-user-session";
                };
            };
        };
    };
}
