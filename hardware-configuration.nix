{
    config,
    lib,
    modulesPath,
    ...
}:
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    boot.initrd.luks.devices."root".device = "/dev/disk/by-label/crypt";

    fileSystems."/" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@"
            "noatime"
            "rw"
            "compress-force=zstd:2"
            "ssd"
            "discard=async"
            "space_cache=v2"
        ];
    };

    fileSystems."/home" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@home"
            "noatime"
        ];
    };

    fileSystems."/nix" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@nix"
            "noatime"
        ];
    };

    fileSystems."/swap" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@swap"
            "noatime"
        ];
    };

    fileSystems."/snapshots" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@snapshots"
            "noatime"
        ];
    };

    fileSystems."/var/log" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@log"
            "noatime"
        ];
    };

    fileSystems."/var/cache" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@cache"
            "noatime"
        ];
    };

    fileSystems."/persist" = {
        device = "/dev/disk/by-label/root";
        fsType = "btrfs";
        options = [
            "subvol=@persist"
            "noatime"
        ];
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-label/BOOT";
        fsType = "vfat";
        options = [
            "fmask=0022"
            "dmask=0022"
        ];
    };

    swapDevices = [
        {
            device = "/swap/file";
            size = 4 * 1024;
        }
    ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
