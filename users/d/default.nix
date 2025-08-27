{ inputs, ... }:
let
    name = "d";
in
{
    imports = [
        inputs.self.nixosModules.shimeoki # note: imports home-manager module
    ];

    users.users."${name}" = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    shimeoki = {
        nushell.users = [ name ];
        greetd.user = name;
    };

    home-manager.users."${name}" = ./hm;
}
