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
    };

    config = lib.mkIf nushell.enable {
        # set as default shell. maybe add as an option?
        users.users.d.shell = pkgs.nushell; # fix: hardcoded username
    };
}
