{ inputs, lib, ... }:
let
    systems = {
        yuki = "x86_64-linux";
    };

    mkSystem =
        host: users:
        let
            system = systems.${host};
        in
        inputs.nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules =
                (lib.map (user: "${inputs.self}/users/${user}") users)
                ++ [ "${inputs.self}/hosts/${host}" ]
                ++ [ { nixpkgs.hostPlatform = system; } ];
        };
in
{
    flake = {
        nixosConfigurations = {
            yuki = mkSystem "yuki" [ "d" ];
        };
    };
}
