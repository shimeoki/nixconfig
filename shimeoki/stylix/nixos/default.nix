{
    config,
    pkgs,
    lib,
    inputs,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.stylix;
in
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    options.shimeoki.stylix = {
        enable = lib.mkEnableOption "stylix" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        };
    };
}
