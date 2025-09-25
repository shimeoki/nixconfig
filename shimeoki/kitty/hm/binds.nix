{ config, lib, ... }:
let
    inherit (config.shimeoki) kitty;

    bind = keys: action: { "kitty_mod+${keys}" = action; };

    binds = lib.mkMerge [
        (bind "/" "scroll_line_up")
        (bind "shift+/" "scroll_line_down")

        (bind "[" "previous_window")
        (bind "]" "next_window")

        (bind "h" "neighboring_window left")
        (bind "j" "neighboring_window bottom")
        (bind "k" "neighboring_window top")
        (bind "l" "neighboring_window right")

        (bind "shift+[" "move_window_backward")
        (bind "shift+]" "move_window_forward")

        (bind "shift+h" "move_window left")
        (bind "shift+j" "move_window bottom")
        (bind "shift+k" "move_window top")
        (bind "shift+l" "move_window right")

        (bind "enter" "new_window_with_cwd")
        (bind "shift+enter" "new_window")

        (bind "backspace" "close_window")
        (bind "shift+backspace" "close_other_windows_in_tab")

        (bind "r" "start_resizing_window")

        (bind "w" "new_tab_with_cwd")
        (bind "shift+w" "new_tab")

        (bind "q" "close_tab")
        (bind "shift+q" "close_other_tabs_in_os_window")

        (bind "," "previous_tab")
        (bind "." "next_tab")

        (bind "shift+," "move_tab_backward")
        (bind "shift+." "move_tab_forward")

        (bind "1" "goto_tab 1")
        (bind "2" "goto_tab 2")
        (bind "3" "goto_tab 3")
        (bind "4" "goto_tab 4")
        (bind "5" "goto_tab 5")
        (bind "6" "goto_tab 6")
        (bind "7" "goto_tab 7")
        (bind "8" "goto_tab 8")
        (bind "9" "goto_tab 9")

        (bind "b" "select_tab")

        (bind "d" "detach_window")
        (bind "shift+d" "detach_tab")

        (bind "a" "detach_window ask")
        (bind "shift+a" "detach_tab ask")

        (bind ";" "launch --location=hsplit --cwd=current")
        (bind "'" "launch --location=vsplit --cwd=current")

        (bind "shift+;" "launch --location=hsplit")
        (bind "shift+'" "launch --location=vsplit")

        (bind "\\" "layout_action rotate")
        (bind "f" "toggle_layout stack")

        (bind "minus" "change_font_size all -2.0")
        (bind "underscore" "change_font_size all 26.0")
        (bind "plus" "change_font_size all +2.0")
        (bind "equal" "change_font_size all +2.0")
        (bind "0" "change_font_size all 0")

        # todo: scrollback
    ];
in
{
    config = lib.mkIf kitty.enable {
        programs.kitty = {
            settings.kitty_mod = "alt";
            keybindings = binds;
        };
    };
}
