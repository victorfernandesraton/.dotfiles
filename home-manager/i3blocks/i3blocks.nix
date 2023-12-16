

{pkgs, ...}:

{
    home = {
        file = {
            ".config/i3blocks/config".source = ./config;
            ".config/i3blocks/battery.sh".source = ./battery.sh;
            ".config/i3blocks/disk_usage".source = ./disk_usage;
            ".config/i3blocks/cpu_usage".source = ./cpu_usage;
            ".config/i3blocks/memory".source = ./memory;
        };
    };
}
