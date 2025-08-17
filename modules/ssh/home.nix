{
    config,
    lib,
    ...
}:
let
    cfg = config.shimeoki.ssh;
in
{
    options.shimeoki.ssh = {
        enable = lib.mkEnableOption "ssh";
    };

    config = lib.mkIf cfg.enable {
        programs.ssh.enable = true;
        services.ssh-agent.enable = true;
    };
}
