{ config, lib, ... }:
let
    module = config.shimeoki;
    cfg = module.uwsm;
    inherit (module) niri;
in
{
    config = lib.mkIf (cfg.enable && niri.enable) {
        programs.uwsm.waylandCompositors.niri = {
            prettyName = "Niri";
            comment = "A scrollable-tiling Wayland compositor";
            binPath = "/run/current-system/sw/bin/niri-session";
        };
    };
}
