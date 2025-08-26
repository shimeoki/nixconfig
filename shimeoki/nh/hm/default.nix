{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nh;
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf nh.enable {
        programs.nh = {
            enable = true;
            # fix: hardcoded path
            flake = "/home/d/nixconfig";
        };
    };
}
