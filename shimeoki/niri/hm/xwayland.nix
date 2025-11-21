{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config.shimeoki) niri;

    pkg = pkgs.xwayland-satellite-unstable;
in
{
    config = lib.mkIf niri.enable {
        home.packages = [ pkg ];
        programs.niri.settings = {
            xwayland-satellite.path = "${lib.getExe pkg}";
        };
    };
}
