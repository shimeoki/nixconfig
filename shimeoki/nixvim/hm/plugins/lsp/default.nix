{ config, lib, ... }:
let
    inherit (config.shimeoki) nixvim dotfiles;
    inherit (nixvim) plugins;
    cfg = plugins.lsp;

    lspconfig =
        name:
        let
            file = "after/lsp/${name}.lua";
        in
        {
            "${file}".source = dotfiles.config "nvim/${file}";
        };
in
{
    options.shimeoki.nixvim = {
        plugins.lsp.enable = lib.mkEnableOption "lsp" // {
            default = plugins.enable;
        };

        lspconfig = lib.mkOption {
            type = with lib.types; functionTo attrs;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            lsp.inlayHints.enable = true;
        };

        shimeoki.nixvim.lspconfig = lspconfig;
    };
}
