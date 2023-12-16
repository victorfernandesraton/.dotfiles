

{pkgs, ...}:
let 
  BASE_DIR = ".config/i3blocks";
  SCRIPT_DIR = "$HOME/${BASE_DIR}";
in 
{
    home = {
        file = {
            "${BASE_DIR}/battery.sh".source = ./battery.sh;
            "${BASE_DIR}/disk_usage".source = ./disk_usage;
            "${BASE_DIR}/cpu_usage".source = ./cpu_usage;
            "${BASE_DIR}/memory".source = ./memory;
            "${BASE_DIR}/config".text = ''
                  [battery]
                  command=sh ${SCRIPT_DIR}/battery.sh
                  interval=10

                  [cpu_usage]
                  command=perl ${SCRIPT_DIR}/cpu_usage 
                  interval=10
                  LABEL=CPU 

                  [memory_ram]
                  command=sh ${SCRIPT_DIR}/memory
                  label=MEM 
                  interval=30

                  [time]
                  command=date +"%a %d/%m/%Y %H:%m"
                  interval=10

                  [caps-lock]
                  command=xset -q | grep Caps | awk '{ print $2, $3, $4 }'
                  interval=1

                  [setxkbmap]
                  command=setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}'
                  interval=1

                  [volume]
                  command=echo " $(amixer sget Master | awk -F"[][]" '/Left:/ { print $2 }')"
                  interval=1
            '';
        };
    };
}
