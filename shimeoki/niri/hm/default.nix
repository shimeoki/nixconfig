{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) niri;
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
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf niri.enable {
        shimeoki.dunst.enable = lib.mkForce true;

        home.packages = with pkgs; [
            nautilus
            wl-clipboard-rs
        ];

        programs.niri.settings = {
            prefer-no-csd = true;
            hotkey-overlay.skip-at-startup = true;
            clipboard.disable-primary = true;
            # todo: screenshot path
        };
    };
}
