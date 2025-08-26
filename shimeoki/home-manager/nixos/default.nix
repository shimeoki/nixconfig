{
    config,
    lib,
    inputs,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) home-manager;
in
{
    imports = [
        inputs.home-manager.nixosModules.home-manager
    ];

    options.shimeoki.home-manager = {
        enable = lib.mkEnableOption "home-manager" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf home-manager.enable {
        home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = { inherit inputs; };
        };
    };
}
