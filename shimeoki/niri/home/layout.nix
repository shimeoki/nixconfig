{
    config = {
        programs.niri.settings.layout = {
            default-column-width = {
                proportion = 0.5;
            };

            preset-column-widths = [
                { proportion = 0.5; }
                { proportion = 1.0; }
                { proportion = 0.3; }
            ];
        };
    };
}
