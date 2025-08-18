{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.lint;
in
{
    options.shimeoki.nixvim.plugins.lint = {
        enable = lib.mkEnableOption "lint" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.lint = {
            enable = true;
            autoCmd = {
                callback.__raw = ''
                    function()
                        require("lint").try_lint()
                    end
                '';
                event = [
                    "BufEnter"
                    "BufWritePost"
                    "InsertLeave"
                ];
            };
        };
    };
}
