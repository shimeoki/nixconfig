{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki.nixvim) plugins;
    cfg = plugins.telescope;
in
{
    # todo: vimgrep arguments

    imports = [
        ./binds.nix
        ./extensions.nix
        ./pickers.nix
        ./view.nix
    ];

    options.shimeoki.nixvim.plugins.telescope = {
        enable = lib.mkEnableOption "telescope" // {
            default = plugins.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.nixvim = {
            extraPackages = [ pkgs.fd ];
            dependencies.ripgrep.enable = lib.mkForce true;
            plugins.web-devicons.enable = lib.mkForce true;
            plugins.telescope.enable = true;
        };
    };
}
