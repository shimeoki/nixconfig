{
    config = {
        programs.niri.settings.layout = {
            gaps = 8;

            center-focused-column = "never";

            default-column-width = {
                proportion = 0.5;
            };

            preset-column-widths = [
                { proportion = 0.5; }
                { proportion = 1.0; }
                { proportion = 0.3; }
            ];

            preset-window-heights = [
                { proportion = 0.5; }
                { proportion = 1.0; }
                { proportion = 0.2; }
            ];

            tab-indicator = {
                hide-when-single-tab = true;
                position = "right";

                gap = 0;
                gaps-between-tabs = 0;
                corner-radius = 0;

                width = 4;
                length.total-proportion = 1.0;
            };

            focus-ring.enable = false;
            border.enable = false;

            background-color = "transparent";
        };
    };
}
