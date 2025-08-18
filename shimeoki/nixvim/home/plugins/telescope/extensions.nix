{ config, lib, ... }:
let
    cfg = config.shimeoki.nixvim.plugins.telescope;
in
{
    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.telescope.extensions = {
            fzf-native = {
                enable = true;
                settings = {
                    fuzzy = true;
                    override_generic_sorter = true;
                    override_file_sorter = true;
                    case_mode = "smart_case";
                };
            };
            ui-select = {
                enable = true;
                settings.__raw = ''
                    { require("telescope.themes").get_dropdown() }
                '';
            };
        };
    };
}
