{ config, lib, ... }:
let
    module = config.shimeoki;
    cfg = module.niri;
    inherit (module) uwsm kitty fuzzel;

    bind = keys: action: { "Mod+${keys}".action = action; };
in
{
    config = lib.mkIf cfg.enable {
        programs.niri.settings.binds =
            with config.lib.niri.actions;
            let
                uwsm-app = spawn "uwsm-app" "--";
                app = if uwsm.enable then uwsm-app else spawn;
            in
            lib.mkMerge [
                (bind "Shift+Slash" show-hotkey-overlay)

                (lib.mkIf kitty.enable (bind "Return" (app "kitty.desktop")))
                (lib.mkIf fuzzel.enable (bind "D" (spawn "fuzzel")))

                (bind "BackSpace" close-window)

                (bind "R" switch-preset-column-width)
                (bind "Shift+R" switch-preset-window-height)
                (bind "Ctrl+R" reset-window-height)

                (bind "Shift+E" quit)
            ];
    };
}
