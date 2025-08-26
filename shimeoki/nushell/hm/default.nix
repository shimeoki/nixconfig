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
        ./settings.nix
        ./prompt.nix
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
