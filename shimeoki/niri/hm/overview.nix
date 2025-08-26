{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.overview = {
            zoom = 0.5;
            workspace-shadow.enable = false;
        };
    };
}
