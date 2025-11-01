{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nh;

    # TODO: match number of boot entries
    keep = 10;

    keepArg = "--keep ${builtins.toString keep}";
in
{
    options.shimeoki.nh = {
        enable = lib.mkEnableOption "nh" // {
            default = shimeoki.enable;
        };

        flake = lib.mkOption {
            type = with lib.types; path;
        };
    };

    config = lib.mkIf nh.enable {
        programs.nh = {
            enable = true;

            inherit (nh) flake;

            clean = {
                enable = true;
                dates = "weekly";
                extraArgs = "${keepArg}";
            };
        };

        home.shellAliases = {
            switch = "nh os switch";
            clean = "nh clean all ${keepArg}";
        };
    };
}
