{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) stylix;
in
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    options.shimeoki.stylix = {
        enable = lib.mkEnableOption "stylix" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf stylix.enable {
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        };
    };
}
