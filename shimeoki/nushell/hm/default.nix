{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nushell dotfiles;
in
{
    imports = [
        ./settings.nix
        ./binds.nix
    ];

    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf nushell.enable {
        programs.nushell = {
            enable = true;
            extraConfig = ''
                source ${dotfiles.config "nushell/up.nu"}
                source ${dotfiles.config "nushell/uuid.nu"}
                use ${dotfiles.config "nushell/prompt.nu"} []
                use ${dotfiles.config "nushell/modules/repo.nu"}
            '';
        };
    };
}
