{
    config = {
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
