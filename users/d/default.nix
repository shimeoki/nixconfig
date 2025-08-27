let
    name = "d";
in
{
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
