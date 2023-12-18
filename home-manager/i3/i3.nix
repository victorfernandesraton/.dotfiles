{pkgs, ...}:

{
  home = {
    packages = with pkgs; [
      dmenu
      networkmanager_dmenu
      dmenu-bluetooth
      clipmenu
    ];
    file = {
      ".config/i3/config".source = ./config;
    };
  };
}
