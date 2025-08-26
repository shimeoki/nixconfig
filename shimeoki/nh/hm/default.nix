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
    options.shimeoki.nh = with lib; {
        enable = mkEnableOption "nh" // {
            default = shimeoki.enable;
        };

        flake = mkOption {
            type = types.path;
        };
    };

    config = lib.mkIf nh.enable {
        programs.nh = {
            enable = true;
            inherit (nh) flake;
        };
    };
}
