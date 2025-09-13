{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki) nixvim;
    inherit (nixvim.languages) shell;
    inherit (nixvim.plugins) conform;

    fmt = [ "shfmt" ];
in
{
    config = lib.mkIf (shell.enable && conform.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.shfmt ];
            plugins.conform-nvim.settings = {
                formatters_by_ft = {
                    sh = fmt;
                    bash = fmt;
                    zsh = fmt;
                };
            };
        };
    };
}
