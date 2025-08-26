{ config, lib, ... }:
let
    inherit (config.shimeoki) uwsm niri;
in
{
    config = lib.mkIf (uwsm.enable && niri.enable) {
        programs.uwsm.waylandCompositors.niri = {
            prettyName = "Niri";
            comment = "A scrollable-tiling Wayland compositor";
            binPath = "/run/current-system/sw/bin/niri-session";
        };
    };
}
