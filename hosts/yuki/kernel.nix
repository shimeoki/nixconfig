{
    boot = {
        initrd.availableKernelModules = [
            "nvme"
            "xhci_pci"
            "usb_storage"
            "sd_mod"
        ];

        kernelModules = [ "kvm-amd" ];
    };
}
