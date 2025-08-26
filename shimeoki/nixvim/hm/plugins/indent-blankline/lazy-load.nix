{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) lz-n;
in
{
    config = lib.mkIf lz-n.enable {
        programs.nixvim.plugins.indent-blankline.lazyLoad.settings = {
            event = [
                "DeferredUIEnter"
            ];
        };
    };
}
