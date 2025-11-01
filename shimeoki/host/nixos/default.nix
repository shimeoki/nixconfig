{ lib, ... }:
{
    options.shimeoki.host = {
        type = lib.mkOption {
            type =
                with lib.types;
                enum [
                    "desktop"
                    "laptop"
                ];
        };

        outputs = lib.mkOption {
            type =
                with lib.types;
                attrsOf (submodule {
                    width = lib.mkOption {
                        type = with lib.types; int;
                    };

                    height = lib.mkOption {
                        type = with lib.types; int;
                    };

                    hz = lib.mkOption {
                        type = with lib.types; int;
                    };
                });
        };
    };
}
