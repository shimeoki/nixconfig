{
    config,
    lib,
    ...
}:
let
    signing = lib.mkIf config.shimeoki.gpg.enable {
        key = "2B092E2DCA05866B";
        signByDefault = true;
    };
in
{
    # todo: user data support

    config = {
        programs.git = {
            userName = "shimeoki";
            userEmail = "shimeoki@gmail.com";
            inherit signing;
        };
    };
}
