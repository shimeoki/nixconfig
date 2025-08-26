{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.animations = {
            window-open.kind.easing = {
                duration-ms = 400;
                curve = "ease-out-expo";
            };

            window-close.kind.easing = {
                duration-ms = 200;
                curve = "linear";
            };
        };
    };
}
