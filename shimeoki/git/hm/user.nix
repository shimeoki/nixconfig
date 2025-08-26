{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki) git gpg;

    signing = lib.mkIf gpg.enable {
        key = "2B092E2DCA05866B";
        signByDefault = true;
    };
in
{
    # todo: user data support

    config = lib.mkIf git.enable {
        programs.git = {
            userName = "shimeoki";
            userEmail = "shimeoki@gmail.com";
            inherit signing;
        };
    };
}
