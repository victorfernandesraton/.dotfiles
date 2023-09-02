{pkgs, ...}:

{
    programs.rofi = {
        enable = true;
        configPath = "./config.rasi";
    };

    home = {
        file = {
            ".config/rofi/config.rasi".source = ./config.rasi;
        };
    };
}
