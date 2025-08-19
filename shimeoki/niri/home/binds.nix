{ config, lib, ... }:
let
    cfg = config.shimeoki.niri;
    bind = keys: action: { "Mod+${keys}".action = action; };
in
{
    config = lib.mkIf cfg.enable {
        shimeoki.kitty.enable = lib.mkForce true;
        shimeoki.fuzzel.enable = lib.mkForce true;
        programs.niri.settings.binds =
            with config.lib.niri.actions;
            lib.mkMerge [
                (bind "Shift+Slash" show-hotkey-overlay)

                (bind "Return" (spawn "kitty"))
                (bind "D" (spawn "fuzzel"))

                (bind "BackSpace" close-window)

                (bind "R" switch-preset-column-width)
                (bind "Shift+R" switch-preset-window-height)
                (bind "Ctrl+R" reset-window-height)

                (bind "Shift+E" quit)
            ];
    };
}
