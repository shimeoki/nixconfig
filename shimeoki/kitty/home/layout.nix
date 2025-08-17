{
    config = {
        programs.kitty.settings = {
            enabled_layouts = "splits, stack";

            window_resize_step_cells = 2;
            window_resize_step_lines = 2;

            window_border_width = "0px";
            draw_minimal_borders = true;

            window_margin_width = 0;
            single_window_margin_width = 0;

            window_padding_width = "6 9";
            single_window_padding_width = -1;

            placement_strategy = "center";

            inactive_text_alpha = 1.0;

            hide_window_decorations = true;
        };
    };
}
