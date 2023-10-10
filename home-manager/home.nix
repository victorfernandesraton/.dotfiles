{ config, pkgs, ... }:


{
    imports = 
        [
        ./tmux.nix
        ./zsh.nix
        ./rofi/rofi.nix
        ./kitty/kitty.nix
        ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "v_raton";
  home.homeDirectory = "/home/v_raton";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    tmux
    scrot
    go
    nodejs_20
    python310
    thunderbird
    fzf
    fd
    podman
    podman-compose
    podman-desktop
    podman-desktop
    rofi-pulse-select
    rofi-bluetooth
    rofi-pulse-select
    rofi-power-menu
    rofi-calc
    libsForQt5.kdeconnect-kde
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/v_raton/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
