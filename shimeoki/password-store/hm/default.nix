{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) password-store;
in
{
    options.shimeoki.password-store = {
        enable = lib.mkEnableOption "password-store" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf password-store.enable {
        programs.password-store.enable = true;
    };
}
