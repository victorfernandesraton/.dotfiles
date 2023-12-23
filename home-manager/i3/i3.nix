{pkgs, ...}:

{
  home = {
    packages = with pkgs; [
      dmenu
      networkmanager_dmenu
      dmenu-bluetooth
      clipmenu
      emojipick
    ];
    file = {
      ".config/i3/config".source = ./config;
    };
  };
}
