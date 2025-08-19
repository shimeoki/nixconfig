{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.telescope;
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.telescope.settings.pickers = {
            find_files.find_command = [
                "rg"
                "--files"
                "--hidden"
                "--glob"
                "!**/.git/*"
            ];
        };
    };
}
