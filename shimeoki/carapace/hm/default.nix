{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) carapace;
in
{
    options.shimeoki.carapace = {
        enable = lib.mkEnableOption "carapace" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf carapace.enable {
        programs.carapace.enable = true;
    };
}
