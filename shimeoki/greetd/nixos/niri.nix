{ config, lib, ... }:
let
    inherit (config.shimeoki) greetd niri uwsm;

    exec = "/run/current-system/sw/bin/niri-session";
    command = if uwsm.enable then "uwsm start -F ${exec}" else exec;
in
{
    options.shimeoki.greetd = {
        user = lib.mkOption {
            type = with lib.types; str;
        };
    };

    config = lib.mkIf (greetd.enable && niri.enable) {
        services.greetd.settings.initial_session = {
            inherit (greetd) user;
            inherit command;
        };
    };
}
