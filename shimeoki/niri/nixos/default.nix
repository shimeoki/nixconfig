{
    config,
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
        programs.niri.enable = true;
    };
}
