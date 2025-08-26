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
        programs.ssh.enable = true;
        services.ssh-agent.enable = true;
    };
}
