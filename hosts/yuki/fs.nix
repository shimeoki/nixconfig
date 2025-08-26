let
    disk = label: "/dev/disk/by-label/${label}";

    device = disk "root";
    fsType = "btrfs";

    vol = options: { inherit device fsType options; };
    subvol =
        name:
        vol [
            "subvol=@${name}"
            "noatime"
        ];
in
{
    boot.initrd.luks.devices."root".device = disk "crypt";

    fileSystems = {
        "/" = vol [
            "subvol=@"
            "noatime"
            "rw"
            "compress-force=zstd:2"
            "ssd"
            "discard=async"
            "space_cache=v2"
        ];

        "/home" = subvol "home";
        "/nix" = subvol "nix";
        "/swap" = subvol "swap";
        "/snapshots" = subvol "snapshots";
        "/var/log" = subvol "log";
        "/var/cache" = subvol "cache";
        "/persist" = subvol "persist";

        "/boot" = {
            device = disk "BOOT";
            fsType = "vfat";
            options = [
                "fmask=0022"
                "dmask=0022"
            ];
        };
    };

    swapDevices = [
        {
            device = "/swap/file";
            size = 4 * 1024;
        }
    ];
}
