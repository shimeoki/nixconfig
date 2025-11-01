{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) git gpg;

    signing = lib.mkIf (gpg.enable && git.signing.gpg) {
        inherit (git.signing) key;
        signByDefault = true;
    };
in
{
    options.shimeoki.git = {
        name = lib.mkOption {
            type = with lib.types; str;
        };

        email = lib.mkOption {
            type = with lib.types; str;
        };

        signing = {
            gpg = lib.mkEnableOption "gpg" // {
                default = gpg.enable;
            };

            key = lib.mkOption {
                type = with lib.types; str;
            };
        };
    };

    config = lib.mkIf git.enable {
        programs.git.settings = {
            inherit signing;
            user = {
                inherit (git) name email;
            };
        };
    };
}
