{ config, lib, ... }:
let
    inherit (config.shimeoki) niri;
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings.window-rules = [
            {
                block-out-from = "screencast";

                matches = [
                    { app-id = "^vesktop$"; }
                    { app-id = "^discord$"; }
                    { app-id = "^.*\\.materialgram$"; }
                    { app-id = "^DeltaChat$"; }
                    { app-id = "^.*\\.Mumble$"; }
                ];
            }
            {
                open-floating = true;

                matches = [
                    {
                        app-id = "^zen.*$";
                        title = "^Picture-in-Picture$";
                    }
                ];
            }
            {
                opacity = 0.9;

                matches = [
                    { app-id = "^kitty$"; }
                ];
            }
        ];
    };
}
