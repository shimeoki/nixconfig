{
    config,
    options,
    pkgs,
    lib,
    inputs,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.stylix;

    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };

    nixos = {
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        };
    };
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

    config = lib.mkIf cfg.enable (
        lib.mkMerge [
            home
            nixos
        ]
    );
}
