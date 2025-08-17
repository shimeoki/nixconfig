{
    config,
    pkgs,
    inputs,
    ...
}:
let
    inherit (config.shimeoki) dotfiles;
in
{
    imports = [
        ./hardware-configuration.nix
    ];

    # enable custom modules
    shimeoki.enable = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };
    home-manager.users.d = ./home.nix;

    boot.loader.systemd-boot.enable = false;
    boot.loader.systemd-boot.configurationLimit = 10;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Moscow";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true;
    };

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

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

    programs.niri.enable = true;

    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };

    environment.systemPackages = with pkgs; [
        sbctl
    ];

    system.stateVersion = "25.05";
}
