{
    config,
    lib,
    ...
}:
let
    inherit (config.shimeoki.nixvim.plugins) conform;
in
{
    config = lib.mkIf conform.enable {
        programs.nixvim.plugins.conform-nvim.settings.formatters = {
            golines.append_args = [
                "--max-len=80"
                "--tab-len=4"
            ];

            clang-format.append_args = [
                "--style"
                "{ BasedOnStyle: Chromium, IndentWidth: 4, LineEnding: LF }"
            ];

            nixfmt.append_args = [
                "--width=80"
                "--indent=4"
            ];

            deno_fmt.append_args = [
                "--use-tabs=false"
                "--indent-width=4"
                "--line-width=80"
                "--no-semicolons=true"
                "--prose-wrap=always"
                "--single-quote=false"
            ];
        };
    };
}
