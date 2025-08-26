{
    config = {
        programs.niri.settings.input = {
            keyboard = {
                # todo: use already defined xkb settings
                xkb = {
                    layout = "us,ru";
                    options = "grp:caps_toggle";
                };
            };

            touchpad = {
                tap = true;

                drag = true;
                drag-lock = true;

                natural-scroll = true;
                scroll-method = "two-finger";

                accel-profile = "flat";
            };

            mouse = {
                scroll-method = "on-button-down";

                accel-profile = "flat";
            };

            warp-mouse-to-focus.enable = true;
            focus-follows-mouse.enable = true;

            power-key-handling.enable = false;

            workspace-auto-back-and-forth = true;
        };
    };
}
