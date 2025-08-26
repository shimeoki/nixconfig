{ pkgs, inputs, ... }:
{
    imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
    ];

    boot = {
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot = {
                enable = false; # note: lanzaboote replaces systemd-boot
                configurationLimit = 10;
            };
        };

        lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
        };
    };

    # note: for secure boot setup and control
    environment.systemPackages = [ pkgs.sbctl ];
}
