{
    config,
    lib,
    modulesPath,
    inputs,
    ...
}:
let
    inherit (config.shimeoki) dotfiles;
in
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        ./fs.nix
        ./kernel.nix
        ./network.nix
        ./boot.nix
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # enable custom modules
    shimeoki.enable = true;

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        extraSpecialArgs = { inherit inputs; };
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

    services.kanata = {
        enable = true;
        keyboards.main = {
            configFile = dotfiles.config "kanata/kanata.kbd";
        };
    };

    system.stateVersion = "25.05";
}
