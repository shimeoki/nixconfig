{
    config,
    lib,
    ...
}:
let
    module = config.shimeoki;
    cfg = module.ssh;
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh" // {
            default = module.enable;
        };
    };

    config = lib.mkIf cfg.enable {
        programs.ssh.enable = true;
        services.ssh-agent.enable = true;
    };
}
