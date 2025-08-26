{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) zoxide;
in
{
    options.shimeoki.zoxide = {
        enable = lib.mkEnableOption "zoxide" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf zoxide.enable {
        programs.zoxide = {
            enable = true;
            options = [ "--cmd=j" ];
        };
    };
}
