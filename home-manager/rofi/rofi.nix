{pkgs, ...}:

{
    programs.rofi = {
        enable = true;
        theme = "./rose-pine.rasi";
        plugins = with pkgs; [
            # rofi-pulse-select
        ];
    };

    home = {
        file = {
            ".config/rofi/rose-pine.rasi".source = ./rose-pine.rasi;
        };
    };
}
