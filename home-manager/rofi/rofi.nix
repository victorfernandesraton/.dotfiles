{pkgs, ...}:

{
    programs.rofi = {
        enable = true;
        configPath = "./config.rasi";
        plugins = with pkgs; [
        ];
    };

    home = {
        file = {
            ".config/rofi/config.rasi".source = ./config.rasi;
        };
    };
}
