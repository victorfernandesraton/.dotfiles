{pkgs, ...}:

{
    programs.rofi = {
        enable = true;
        theme = "./rose-pine.rasi";
        plugins = with pkgs; [
            rofi-pulse-select
            rofi-bluetooth
            rofi-power-menu
            rofi-calc
        ];
        extraConfig = {
         modi = "drun,run,ssh,calc,filebrowser";
        };
    };

    home = {
        file = {
            ".config/rofi/rose-pine.rasi".source = ./rose-pine.rasi;
        };
    };
}
