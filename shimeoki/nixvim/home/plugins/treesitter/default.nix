{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.treesitter;
in
{
    options.shimeoki.nixvim.plugins.treesitter = {
        enable = lib.mkEnableOption "treesitter" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            dependencies = {
                gcc.enable = lib.mkForce true;
                tree-sitter.enable = lib.mkForce true;
            };
            plugins.treesitter = {
                # todo: use main branch
                enable = true;
                settings = {
                    highlight = {
                        enable = true;
                        additional_vim_regex_highlighting = false;
                    };
                };
                languageRegister = {
                    css = "gtkcss";
                    bash = [
                        "sh"
                        "zsh"
                    ];
                };
            };
        };
    };
}
