{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.environment = {
            QT_QPA_PLATFORM = "wayland";
            NIXOS_OZONE_WL = "1"; # note: electron apps
        };
    };
}
