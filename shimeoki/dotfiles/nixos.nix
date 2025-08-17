{ options, lib, ... }:
let
    home = lib.optionalAttrs (options ? home-manager) {
        home-manager.sharedModules = [ ./home.nix ];
    };
in
{
    imports = [ ./shared.nix ];

    config = lib.mkMerge [ home ];
}
