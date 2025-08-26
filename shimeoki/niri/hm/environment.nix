{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.environment = {
            QT_QPA_PLATFORM = "wayland";
            DISPLAY = ":0";
        };
    };
}
