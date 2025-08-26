{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.dunst;

    padding = 16;
    icon_size = 32;
in
{
    options.shimeoki.dunst = {
        enable = lib.mkEnableOption "dunst" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        services.dunst = {
            enable = true;
            settings.global = {
                width = 480;
                height = "(0, 320)";

                origin = "top-right";
                offset = "(16, 16)";

                progress_bar = true;
                progress_bar_min_width = 150;
                progress_bar_max_width = 300;
                progress_bar_height = 10;
                progress_bar_frame_width = 0;
                progress_bar_corner_radius = 0;

                separator_height = 8;

                inherit padding;
                horizontal_padding = padding;
                text_icon_padding = padding;
                corner_radius = 0;

                frame_width = 0;
                gap_size = 0;

                notification_limit = 4;
                show_age_threshold = 60;
                indicate_hidden = true;
                sort = true;
                stack_duplicates = true;
                hide_duplicate_count = true;

                line_height = 0;

                markup = "full";
                format = "<b>%s / %a</b>\\n%b";
                ignore_newline = false;
                alignment = "left";
                vertical_alignment = "center";
                ellipsize = "end";
                show_indicators = false;

                icon_corner_radius = 0;
                icon_position = "left";
                min_icon_size = icon_size;
                max_icon_size = 3 * icon_size;

                sticky_history = true;
                history_length = 20;

                mouse_left_click = "close_current";
                mouse_middle_click = "do_action, close_current";
                mouse_right_click = "close_all";
            };
        };
    };
}
