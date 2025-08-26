{ config, lib, ... }:
let
    module = config.shimeoki;
    cfg = module.greetd;
    inherit (module) niri uwsm;

    # fix: hardcoded username
    user = "d";

    exec = "/run/current-system/sw/bin/niri-session";
    command = if uwsm.enable then "uwsm start -F ${exec}" else exec;
in
{
    config = lib.mkIf (cfg.enable && niri.enable) {
        services.greetd.settings.initial_session = {
            inherit command user;
        };
    };
}
