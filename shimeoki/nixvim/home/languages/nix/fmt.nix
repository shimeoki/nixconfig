{
    config,
    pkgs,
    lib,
    ...
}:
let
    cfg = config.shimeoki.nixvim.languages.nix;
    inherit (config.shimeoki.nixvim.plugins) conform;
in
{
    # todo: width and height based on opts

    config = lib.mkIf (cfg.enable && conform.enable) {
        programs.nixvim = {
            extraPackages = [ pkgs.nixfmt ];
            plugins.conform-nvim.settings = {
                formatters_by_ft.nix = [ "nixfmt" ];
                formatters.nixfmt = {
                    append_args = [
                        "--width=80"
                        "--indent=4"
                    ];
                };
            };
        };
    };
}
