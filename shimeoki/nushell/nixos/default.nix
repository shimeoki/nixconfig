{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nushell;
in
{
    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = shimeoki.enable;
        };

        users = lib.mkOption {
            type = with lib.types; listOf str;
        };
    };

    config = lib.mkIf nushell.enable {
        users.users = lib.genAttrs nushell.users (user: {
            shell = pkgs.nushell;
        });
    };
}
