

{pkgs, ...}:
let 
  BASE_DIR = ".config/i3blocks";
  SCRIPT_DIR = "$HOME/${BASE_DIR}";
in 
{
    home = {
      packages = with pkgs; [
        acpi
        sysstat
      ];
        file = {
            "${BASE_DIR}/battery".text = /*bash*/ ''
                BAT=$(acpi -b | grep -E -o '[0-9]{1,3}?%')

                # Full and short texts
                echo "BAT: $BAT"

                # Set urgent flag below 5% or use orange below 20%
                [ ${"$"}{BAT%?} -le 15 ] && exit 33
                [ ${"$"}{BAT%?} -le 25 ] && echo "#FF8000"

                exit 0
            '';
            "${BASE_DIR}/disk_usage".source = ./disk_usage;
            "${BASE_DIR}/cpu_usage".source = ./cpu_usage;
            "${BASE_DIR}/memory".source = ./memory;
            "${BASE_DIR}/config".text = ''
                  [battery]
                  command=sh ${SCRIPT_DIR}/battery
                  interval=10

                  [cpu_usage]
                  command=perl ${SCRIPT_DIR}/cpu_usage 
                  interval=10
                  LABEL=CPU 
                  T_WARN=70
                  T_CRIT=90
                  COLOR_NORMAL=#e0def4
                  COLOR_WARN=#f6c177
                  COLOR_CRIT=#eb6f92


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
