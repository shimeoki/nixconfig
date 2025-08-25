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
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # enable custom modules
    shimeoki.enable = true;

    home-manager = {
        users.d = ./home.nix;
    };

    time.timeZone = "Europe/Moscow";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true;
    };

    nix.settings = {
        warn-dirty = false;
        experimental-features = [
            "nix-command"
            "flakes"
        ];
    };

    services.xserver.xkb.layout = "us,ru";
    services.xserver.xkb.options = "grp:caps_toggle";

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    # fix: enable only on laptops
    services.tlp = {
        enable = true;
    };

    users.users.d = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
    };

    system.stateVersion = "25.05";
}
