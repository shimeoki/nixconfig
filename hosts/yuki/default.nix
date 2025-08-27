{
    inputs,
    modulesPath,
    ...
}:
{
    imports = [
        inputs.self.nixosModules.shimeoki
        (modulesPath + "/installer/scan/not-detected.nix")
        ./fs.nix
        ./kernel.nix
        ./network.nix
        ./boot.nix
        ./xkb.nix
        ./console.nix
        ./audio.nix
    ];

    time.timeZone = "Europe/Moscow";
    i18n.defaultLocale = "en_US.UTF-8";

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
