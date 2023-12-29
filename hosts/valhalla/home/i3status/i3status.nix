{ pkgs, ... }:

{
  home = {
    file = {
      ".config/i3status/.i3status.conf".text = ''
        general {
                colors = true
                interval = 5
        }

        order += "load"
        order += "battery 0"
        order += "memory"
        order += "cpu_usage"
        order += "disk /"
        order += "tztime local"
        order += "volume master"
        order += "wireless _first_"
        wireless _first_ {
                format_up = "W: (%essid) %ip"
                format_down = "W: down"
        }

        ethernet _first {
                format_up = "E: %ip (%speed)"
                format_down = "E: down"
        }

        battery 0 {
                format = "%status %percentage %remaining"
                format_down = "No battery"
                status_chr = "⚡ CHR"
                status_bat = "🔋 BAT"
                status_unk = "? UNK"
                status_full = "☻ FULL"
                path = "/sys/class/power_supply/BAT%d/uevent"
                low_threshold = 25
                last_full_capacity = true
        }

        run_watch DHCP {
                pidfile = "/var/run/dhclient*.pid"
        }

        run_watch VPNC {
                pidfile = "/var/run/vpnc/pid"
        }

        path_exists VPN {
                path = "/proc/sys/net/ipv4/conf/tun0"
        }

        tztime local {
                format = "%d/%m/%Y %H:%M"
        }


        load {
                format = "%5min"
        }

        memory {
                format = "%used"
                threshold_degraded = "10%"
                format_degraded = "MEMORY: %free"
        }

        disk "/" {
                format = "%free"
        }

        cpu_usage {
          format = "CPU: %usage"
        }


        read_file uptime {
                path = "/proc/uptime"
        }

        volume master {
           format = " %volume"
           format_muted = " %volume"
           device = "default"
           mixer = "Master"
           mixer_idx = 0
        }
      '';
    };
  };
}
