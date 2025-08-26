{ lib, ... }:
{
    networking = {
        useDHCP = lib.mkDefault true;
        hostName = "yuki";
        networkmanager.enable = true;
    };
}
