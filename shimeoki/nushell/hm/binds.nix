{ config, lib, ... }:
let
    inherit (config.shimeoki) nushell;

    bindRaw =
        keybind:
        keybind
        // {
            mode = [
                "vi_normal"
                "vi_insert"
            ];
        };

    bind = keybind: bindRaw (keybind // { modifier = "control"; });
    bindShift = keybind: bindRaw (keybind // { modifier = "control_shift"; });
in
{
    options.shimeoki.nushell = {
        bindRaw = lib.mkOption {
            type = with lib.types; functionTo attrs;
        };

        bind = lib.mkOption {
            type = with lib.types; functionTo attrs;
        };

        bindShift = lib.mkOption {
            type = with lib.types; functionTo attrs;
        };
    };

    config = lib.mkIf nushell.enable {
        programs.nushell.settings.keybindings = [
            (bind {
                name = "menu_down";
                keycode = "char_j";
                event.send = "MenuDown";
            })

            (bind {
                name = "menu_up";
                keycode = "char_k";
                event.send = "MenuUp";
            })

            (bind {
                name = "menu_left";
                keycode = "char_h";
                event.send = "MenuLeft";
            })

            (bind {
                name = "menu_right";
                keycode = "char_l";
                event.send = "MenuRight";
            })

            (bind {
                name = "hint_word_complete";
                keycode = "char_;";
                event.send = "HistoryHintWordComplete";
            })

            (bind {
                name = "hint_complete";
                keycode = "char_'";
                event.send = "HistoryHintComplete";
            })

            (bind {
                name = "clear";
                keycode = "char_u";
                event.edit = "Clear";
            })

            (bind {
                name = "clear_screen";
                keycode = "backspace";
                event.send = "ClearScreen";
            })
        ];

        shimeoki.nushell = {
            inherit bindRaw bind bindShift;
        };
    };
}
