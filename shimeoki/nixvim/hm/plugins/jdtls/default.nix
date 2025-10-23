{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.nixvim) plugins;
in
{
    options.shimeoki.plugins.jdtls = {
        enable = lib.mkEnableOption "jdtls" // {
            default = true;
        };
    };

    config = lib.mkIf plugins.enable {
        programs.nixvim = {
            extraPlugins = [
                pkgs.vimPlugins.nvim-jdtls
            ];

            extraPackages = [
                pkgs.jdt-language-server
            ];
        };
    };
}
