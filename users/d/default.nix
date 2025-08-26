{
    imports = [
        ./shimeoki.nix
    ];

    users.users.d = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    home-manager.users.d = ./hm;
}
