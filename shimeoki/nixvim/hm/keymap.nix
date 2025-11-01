{ lib, ... }:
let
    bind =
        {
            keys,
            action,
            mod ? "<leader>",
            cmd ? true,
            lua ? false,
            silent ? true,
            modes ? [
                "n"
                "v"
            ],
        }:
        let
            key = {
                key = "${mod}${keys}";
                options.silent = silent;
                mode = modes;
            };
            map =
                if lua then
                    {
                        action.__raw = action;
                    }
                else
                    {
                        action = if cmd then "<cmd>${action}<cr>" else action;
                    };
        in
        lib.mkMerge [
            key
            map
        ];
in
{
    options.shimeoki.nixvim.keymap = {
        bind = lib.mkOption {
            type = with lib.types; functionTo attrs;
        };
    };

    config = {
        shimeoki.nixvim.keymap = { inherit bind; };
    };
}
