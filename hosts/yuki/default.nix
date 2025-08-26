{
    config,
    lib,
    modulesPath,
    ...
}:
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        ./fs.nix
        ./kernel.nix
        ./network.nix
        ./boot.nix
        ./hm.nix
        ./xkb.nix
        ./console.nix
        ./audio.nix
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # enable custom modules
    shimeoki = {
        enable = true;

        host = {
            type = "laptop";
            outputs = {
                "eDP-1" = {
                    width = 1920;
                    height = 1080;
                    hz = 60;
                };
            };
        };
    };

    home-manager = {
        users.d = ./home.nix;
    };

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.d = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    nix.settings = {
        warn-dirty = false;
        experimental-features = [
            "nix-command"
            "flakes"
        ];
    };

    system.stateVersion = "25.05";
}
