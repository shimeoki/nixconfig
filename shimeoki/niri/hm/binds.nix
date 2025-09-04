{ config, lib, ... }:
let
    inherit (config.lib.niri) actions;
    inherit (config.shimeoki)
        niri
        uwsm
        kitty
        fuzzel
        zen-browser
        ;

    bindRaw =
        {
            keys,
            action,
            cooldown-ms ? null,
            repeat ? true,
            allow-inhibiting ? true,
        }:
        {
            "Mod+${keys}" = {
                inherit
                    action
                    cooldown-ms
                    repeat
                    allow-inhibiting
                    ;
            };
        };

    bind = keys: action: bindRaw { inherit keys action; };

    bindNoRepeat =
        keys: action:
        bindRaw {
            inherit keys action;
            repeat = false;
        };

    bindNoInhibiting =
        keys: action:
        bindRaw {
            inherit keys action;
            allow-inhibiting = false;
        };

    bindCooldown =
        cooldown-ms: keys: action:
        bindRaw { inherit keys action cooldown-ms; };

    bindHorizontal = bindCooldown 50;
    bindVertical = bindCooldown 100;

    bindIf =
        cond: keys: action:
        lib.mkIf cond (bind keys action);

    app = with actions; if uwsm.enable then spawn "uwsm-app" "--" else spawn;

    # note: https://github.com/sodiboo/niri-flake/issues/1018
    bindNums =
        with lib;
        key: action:
        forEach (range 1 9) (
            n:
            let
                num = builtins.toString n;
                keys = if key == "" then num else "${key}+${num}";
            in
            {
                "Mod+${keys}".action."${action}" = n;
            }
        );

    binds = with actions; [
        (bind "Shift+Slash" show-hotkey-overlay)

        (bindIf kitty.enable "Return" (app "kitty"))
        (bindIf zen-browser.enable "B" (app "zen"))
        # todo: obsidian
        # todo: materialgram
        # todo: pwvucontrol
        (bindIf fuzzel.enable "D" (spawn "fuzzel"))
        # todo: scripts

        (bindNoRepeat "Tab" toggle-overview)
        (bindNoRepeat "MouseForward" toggle-overview)

        (bind "BackSpace" close-window)
        (bind "MouseMiddle" close-window)

        (bind "U" focus-workspace-down)
        (bind "I" focus-workspace-up)
        (bind "H" focus-column-left)
        (bind "J" focus-window-down)
        (bind "K" focus-window-up)
        (bind "L" focus-column-right)

        (bind "Ctrl+U" move-workspace-down)
        (bind "Ctrl+I" move-workspace-up)
        (bind "Ctrl+H" move-column-left)
        (bind "Ctrl+J" move-window-down)
        (bind "Ctrl+K" move-window-up)
        (bind "Ctrl+L" move-column-right)

        (bind "Shift+U" move-window-to-workspace-down)
        (bind "Shift+I" move-window-to-workspace-up)
        (bind "Ctrl+Shift+U" move-column-to-workspace-down)
        (bind "Ctrl+Shift+I" move-column-to-workspace-up)

        (bindVertical "WheelScrollDown" focus-workspace-down)
        (bindVertical "WheelScrollUp" focus-workspace-up)
        (bindVertical "Ctrl+WheelScrollDown" move-column-to-workspace-down)
        (bindVertical "Ctrl+WheelScrollUp" focus-workspace-up)

        (bindHorizontal "WheelScrollRight" focus-column-right)
        (bindHorizontal "WheelScrollLeft" focus-column-left)
        (bindHorizontal "Ctrl+WheelScrollRight" move-column-right)
        (bindHorizontal "Ctrl+WheelScrollLeft" move-column-left)

        (bindHorizontal "Shift+WheelScrollDown" focus-column-right)
        (bindHorizontal "Shift+WheelScrollUp" focus-column-left)
        (bindHorizontal "Shift+Ctrl+WheelScrollDown" move-column-right)
        (bindHorizontal "Shift+Ctrl+WheelScrollUp" move-column-left)

        (bindNums "" "focus-workspace")
        (bindNums "Ctrl" "move-column-to-workspace")
        (bindNums "Shift" "move-window-to-workspace")

        (bind "Comma" consume-or-expel-window-left)
        (bind "Period" consume-or-expel-window-right)

        (bind "R" switch-preset-column-width)
        (bind "Shift+R" switch-preset-window-height)
        (bind "Ctrl+R" reset-window-height)

        (bind "F" maximize-column)
        (bind "Shift+F" fullscreen-window)
        (bind "Ctrl+F" expand-column-to-available-width)

        (bind "C" center-column)
        (bind "Ctrl+C" center-visible-columns)

        (bind "Minus" (set-column-width "-10%"))
        (bind "Equal" (set-column-width "+10%"))

        (bind "Shift+Minus" (set-window-height "-10%"))
        (bind "Shift+Equal" (set-window-height "+10%"))

        (bind "MouseBack" toggle-window-floating)
        (bind "V" toggle-window-floating)
        (bind "Shift+V" switch-focus-between-floating-and-tiling)

        (bind "W" toggle-column-tabbed-display)

        (bind "S" (screenshot {
            show-pointer = false;
        }))

        # note: https://github.com/sodiboo/niri-flake/issues/922#issuecomment-2729519779
        { "Mod+Shift+S".action.screenshot-screen = [ ]; }

        (bind "Ctrl+S" screenshot-window)

        (bindNoInhibiting "Escape" toggle-keyboard-shortcuts-inhibit)

        (bind "Shift+E" quit)
        (bind "Shift+P" power-off-monitors)
    ];
in
{
    config = lib.mkIf niri.enable {
        programs.niri.settings = {
            binds = with lib; mkMerge (flatten binds);
            input = {
                mod-key = "Super";
                mod-key-nested = "Alt";
            };
        };
    };
}
