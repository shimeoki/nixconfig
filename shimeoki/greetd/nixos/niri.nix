{ config, lib, ... }:
let
    inherit (config.shimeoki) greetd niri uwsm;

    # fix: hardcoded username
    user = "d";

    exec = "/run/current-system/sw/bin/niri-session";
    command = if uwsm.enable then "uwsm start -F ${exec}" else exec;
in
{
    config = lib.mkIf (greetd.enable && niri.enable) {
        services.greetd.settings.initial_session = {
            inherit command user;
        };
    };
}
