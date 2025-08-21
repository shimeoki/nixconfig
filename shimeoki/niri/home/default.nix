{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.niri;
in
{
    imports = [
        ./binds.nix
        ./layout.nix
        ./animations.nix
        ./environment.nix
        ./overview.nix
        ./window-rules.nix
        ./layer-rules.nix
        ./input.nix
        # todo: output
        # todo: cursor
    ];

    options.shimeoki.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        shimeoki.dunst.enable = lib.mkForce true;
        programs.niri.settings = {
            prefer-no-csd = true;
            hotkey-overlay.skip-at-startup = true;
            clipboard.disable-primary = true;
            # todo: screenshot path
        };
    };
}
