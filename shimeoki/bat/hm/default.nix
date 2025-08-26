{
    config,
    pkgs,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) bat;
in
{
    imports = [
        ./aliases.nix
    ];

    options.shimeoki.bat = {
        enable = lib.mkEnableOption "bat" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf bat.enable {
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
