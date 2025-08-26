{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty;
in
{
    config = lib.mkIf kitty.enable {
        programs.kitty.settings = {
            tab_bar_edge = "top";
            tab_bar_align = "left";

            tab_bar_margin_width = 0;
            tab_bar_background = "none";

            tab_bar_style = "hidden";
            tab_powerline_style = "slanted";
            tab_separator = ''""'';

            tab_title_template = ''" {fmt.fg.red}[bell_symbol]{activity_symbol}{fmt.fg.tab} {index} {title} {tab.last_focused_progress_percent} "'';

            tab_bar_min_tabs = 2;
            tab_switch_strategy = "previous";
        };
    };
}
