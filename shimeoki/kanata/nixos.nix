{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) kanata dotfiles;
in
{
    options.shimeoki.kanata = {
        enable = lib.mkEnableOption "kanata" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf kanata.enable {
        services.kanata = {
            enable = true;
            keyboards.main = {
                configFile = dotfiles.config "kanata/kanata.kbd";
            };
        };
    };
}
