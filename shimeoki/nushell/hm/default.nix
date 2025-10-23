{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nushell dotfiles;

    env = "IN_NIX_SHELL";
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

                def pkg [name: string]: nothing -> nothing {
                    nix shell --set-env-var ${env} impure $"nixpkgs#($name)"
                }
            ''; # TODO: move 'pkg' to another place
        };
    };
}
