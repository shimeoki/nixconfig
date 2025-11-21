{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) niri;
in
{
    imports = [
        inputs.niri.nixosModules.niri
    ];

    options.shimeoki.niri = {
        enable = lib.mkEnableOption "niri" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf niri.enable {
        nixpkgs.overlays = [ inputs.niri.overlays.niri ];
        programs.niri = {
            enable = true;
            package = pkgs.niri-unstable;
        };
    };
}
