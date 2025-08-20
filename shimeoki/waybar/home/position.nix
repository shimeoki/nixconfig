let
    margin = 4;
in
{
    config = {
        programs.waybar.settings.main = {
            layer = "top";
            position = "top";
            margin-top = 2 * margin;
            margin-left = margin;
            margin-right = margin;
        };
    };
}
