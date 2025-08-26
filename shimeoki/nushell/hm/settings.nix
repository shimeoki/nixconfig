{ config, ... }:
let
    inherit (config.shimeoki) kitty;
in
{
    config = {
        programs.nushell.settings = {
            show_banner = false;

            edit_mode = "vi";
            buffer_editor = "editor";

            cursor_shape = {
                emacs = "inherit";
                vi_insert = "line";
                vi_normal = "block";
            };

            history = {
                file_format = "sqlite";
                max_size = 1000000;
                sync_on_enter = true;
                isolation = false;
            };

            completions.algorithm = "fuzzy";

            use_kitty_protocol = kitty.enable;
            use_ansi_coloring = true;

            footer_mode = "auto";
            table.mode = "single";

            display_errors = {
                exit_code = false;
                termination_signal = false;
            };
        };
    };
}
