{
    config,
    lib,
    inputs,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.zen-browser;
in
{
    imports = [
        inputs.zen-browser.homeModules.twilight
        ./policies.nix
        ./xdg.nix
        ./profiles.nix
        ./stylix.nix
    ];

    options.shimeoki.zen-browser = {
        enable = lib.mkEnableOption "zen-browser" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.zen-browser.enable = true;
    };
}
