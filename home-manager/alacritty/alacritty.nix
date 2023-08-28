{pkgs, ...}:

{
  home = {
    file = {
      ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
      ".config/alacritty/rose-pine.yml".source = ./rose-pine.yml;
    };
  };
}
