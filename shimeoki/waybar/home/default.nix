{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.waybar;

    inherit (config.shimeoki) dotfiles;
in
{
    # todo: don't hardcode bar name

    imports = [
        ./position.nix
        ./modules.nix

        ./hyprland
        ./niri
        ./backlight.nix
        ./battery.nix
        ./bluetooth.nix
        ./clock.nix
        ./keyboard-state.nix
        ./network.nix
        ./wireplumber.nix
        ./cava.nix
        ./mpd.nix
        ./tray.nix
    ];

    options.shimeoki.waybar = {
        enable = lib.mkEnableOption "waybar" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.waybar = {
            enable = true;
            # fix: doesn't read the file automatically
            style = builtins.readFile (dotfiles.config "waybar/default.css");
        };
    };
}
