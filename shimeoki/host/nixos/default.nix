{ lib, ... }:
{
    options.shimeoki.host = with lib; {
        type = mkOption {
            type = types.enum [
                "desktop"
                "laptop"
            ];
        };

        outputs = mkOption {
            type = types.attrsOf (
                types.submodule {
                    width = mkOption {
                        type = types.int;
                    };

                    height = mkOption {
                        type = types.int;
                    };

                    hz = mkOption {
                        type = types.int;
                    };
                }
            );
        };
    };
}
