{
    config = {
        programs.niri.settings.environment = {
            QT_QPA_PLATFORM = "wayland";
            DISPLAY = ":0";
        };
    };
}
