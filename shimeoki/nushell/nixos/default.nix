{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.nushell;
in
{
    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        # set as default shell. maybe add as an option?
        users.users.d.shell = pkgs.nushell; # fix: hardcoded username
    };
}
