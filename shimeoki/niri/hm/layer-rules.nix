{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.layer-rules = [
            {
                block-out-from = "screencast";
                matches = [ { namespace = "^notifications$"; } ];
            }
            {
                place-within-backdrop = true;
                matches = [ { namespace = "^swww-daemon$"; } ];
            }
            {
                opacity = 0.9;
                matches = [ { namespace = "^waybar$"; } ];
            }
        ];
    };
}
