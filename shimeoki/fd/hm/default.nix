{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) fd;
in
{
    options.shimeoki.fd = {
        enable = lib.mkEnableOption "fd" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf fd.enable {
        programs.fd = {
            enable = true;
            hidden = true;
            ignores = [ ".git" ];
        };
    };
}
