{
    config,
    lib,
    ...
}:
let
    inherit (config) shimeoki;
    inherit (shimeoki) ssh;
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh" // {
            default = shimeoki.enable;
        };
    };

    config = lib.mkIf ssh.enable {
        services.ssh-agent.enable = true;
        programs.ssh = {
            enable = true;
            enableDefaultConfig = false; # NOTE: because deprecated
        };
    };
}
