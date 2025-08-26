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
    options.shimeoki.nushell = with lib; {
        enable = mkEnableOption "nushell" // {
            default = shimeoki.enable;
        };

        users = mkOption {
            type = with types; listOf str;
        };
    };

    config = lib.mkIf nushell.enable {
        users.users = lib.genAttrs nushell.users (user: {
            shell = pkgs.nushell;
        });
    };
}
