{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      libnotify
      dmenu
      networkmanager_dmenu
      dmenu-bluetooth
      clipmenu
      xclip
      emojipick
    ];
    file = {
      ".config/i3/config".source = ./config;
    };
  };
}
