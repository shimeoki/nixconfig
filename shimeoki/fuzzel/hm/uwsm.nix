{ config, lib, ... }:
let
    inherit (config.shimeoki) fuzzel uwsm;
in
{
    config = lib.mkIf (fuzzel.enable && uwsm.enable) {
        programs.fuzzel.settings.main = {
            launch-prefix = "uwsm-app --";
        };
    };
}
