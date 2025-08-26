{ config, lib, ... }:
let
    inherit (config.shimeoki) uwsm;
in
{
    config = lib.mkIf uwsm.enable {
        programs.fuzzel.settings.main = {
            launch-prefix = "uwsm-app --";
        };
    };
}
