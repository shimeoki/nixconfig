{ config, lib, ... }:
let
    inherit (config.shimeoki.nixvim.plugins) lz-n;
in
{
    config = lib.mkIf lz-n.enable {
        programs.nixvim.plugins.conform-nvim.lazyLoad.settings = {
            # todo: custom cmd's
            event = [
                "DeferredUIEnter"
                "BufWritePre"
            ];
        };
    };
}
