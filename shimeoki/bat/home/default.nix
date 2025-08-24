{
    config,
    pkgs,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.bat;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.bat = {
        enable = lib.mkEnableOption "bat" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.bat = {
            enable = true;
            extraPackages = with pkgs.bat-extras; [ batman ];
            config = {
                style = "header,changes,numbers";
                tabs = "4";
            };
        };
    };
}
