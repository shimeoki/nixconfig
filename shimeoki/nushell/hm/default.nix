{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) nushell;
in
{
    imports = [
        ./nix.nix
        ./prompt.nix
        ./settings.nix
    ];

    options.shimeoki.nushell = {
        enable = lib.mkEnableOption "nushell" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf nushell.enable {
        programs.nushell.enable = true;
    };
}
