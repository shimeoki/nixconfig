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

    theme = "gruvbox-dark-hard";

    # monospace for everything
    font = {
        package = pkgs.nerd-fonts.noto;
        name = "NotoSansM Nerd Font";
    };

    emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
    };
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
            base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

            fonts = {
                monospace = font;
                serif = font;
                sansSerif = font;
                inherit emoji;
            };
        };
    };
}
