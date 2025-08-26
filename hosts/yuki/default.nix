{
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
        ./shimeoki.nix
    ];

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";

    nix.settings = {
        warn-dirty = false;
        experimental-features = [
            "nix-command"
            "flakes"
        ];
    };

    hardware.cpu.amd.updateMicrocode = true;
    system.stateVersion = "25.05";
}
