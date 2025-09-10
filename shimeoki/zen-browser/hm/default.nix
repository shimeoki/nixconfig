{
    config,
    lib,
    inputs,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) zen-browser;
in
{
    imports = [
        inputs.zen-browser.homeModules.twilight
        ./policies.nix
        ./xdg.nix
        ./profiles.nix
        ./stylix.nix
        ./extensions.nix
    ];

    options.shimeoki.zen-browser = {
        enable = lib.mkEnableOption "zen-browser" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf zen-browser.enable {
        programs.zen-browser.enable = true;
    };
}
