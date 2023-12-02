
{pkgs, ...}:

{
    home = {
        file = {
            ".config/i3status/.i3status.conf".source = ./config;
        };
    };
}
