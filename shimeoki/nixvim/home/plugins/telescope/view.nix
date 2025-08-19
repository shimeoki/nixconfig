{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.telescope;

    preview_width = 80; # todo: maybe use width from opts?
    preview_cutoff = preview_width + preview_width / 2;
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.telescope.settings.defaults = {
            sorting_strategy = "ascending";
            wrap_results = true;
            prompt_prefix = "";
            selection_caret = " ";
            entry_prefix = " ";
            border = true;
            dynamic_preview_title = true;
            results_title = false;
            layout_strategy = "flex";
            layout_config = {
                scroll_speed = 4;
                horizontal = {
                    anchor = "CENTER";

                    height.padding = 0;
                    width.padding = 0;

                    inherit preview_width preview_cutoff;

                    prompt_position = "top";
                    mirror = false;
                };
                vertical = {
                    anchor = "CENTER";

                    height.padding = 0;
                    width.padding = 0;

                    prompt_position = "top";
                    mirror = true;
                };
                flex = {
                    flip_columns = preview_cutoff;
                };
            };
        };
    };
}
