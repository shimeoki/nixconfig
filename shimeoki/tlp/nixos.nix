{ config, lib, ... }:
let
    inherit (config.shimeoki) host tlp;
in
{
    options.shimeoki.tlp = {
        enable = lib.mkEnableOption "tlp" // {
            default = host.type == "laptop";
        };
    };

    config = lib.mkIf tlp.enable {
        services.tlp.enable = true;
    };
}
