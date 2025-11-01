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
    options.shimeoki.git = with lib; {
        name = mkOption {
            type = types.str;
        };

        email = mkOption {
            type = types.str;
        };

        signing = {
            gpg = mkEnableOption "gpg" // {
                default = gpg.enable;
            };

            key = mkOption {
                type = types.str;
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
