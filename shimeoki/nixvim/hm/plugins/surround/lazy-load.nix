{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) surround lz-n;
in
{
    config = lib.mkIf (surround.enable && lz-n.enable) {
        programs.nixvim.plugins.nvim-surround.lazyLoad.settings = {
            event = [
                "DeferredUIEnter"
            ];
        };
    };
}
