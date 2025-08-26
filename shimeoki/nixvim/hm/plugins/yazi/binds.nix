{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.yazi;
    bind =
        keys: action:
        config.shimeoki.nixvim.keymap.bind {
            inherit keys;
            action = "Yazi ${action}";
        };
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.keymaps = [
            (bind "e" "")
            (bind "E" "cwd")
            (bind "<c-e>" "toggle")
        ];
    };
}
