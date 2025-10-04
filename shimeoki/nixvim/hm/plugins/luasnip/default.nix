{ config, lib, ... }:
let
    inherit (config) shimeoki;
    inherit (shimeoki) dotfiles;
    inherit (shimeoki.nixvim) plugins;
    cfg = plugins.luasnip;
in
{
    imports = [
        ./binds.nix
        ./lazy-load.nix
    ];

    options.shimeoki.nixvim.plugins.luasnip = {
        enable = lib.mkEnableOption "luasnip" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim.plugins.luasnip = {
            # todo: virtual text
            enable = true;
            settings = {
                region_check_events = [ "InsertEnter" ];
                delete_check_events = [
                    "InsertLeave"
                    "TextChanged"
                ];
            };
            fromVscode = [ { } ];
            fromLua = [
                { }
                { paths = dotfiles.config "nvim/luasnippets"; }
            ];
        };
    };
}
