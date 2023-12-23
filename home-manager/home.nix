{ config, pkgs, ... }:

let
  devPkgs = import ./devPkgs.nix pkgs;
in
{
  imports =
    [
      ./tmux/tmux.nix
      ./zsh.nix
      ./kitty/kitty.nix
      ./nvim/nvim.nix
      ./i3/i3.nix
      ./i3status/i3status.nix
      ./i3blocks/i3blocks.nix
      ./helix/helix.nix
    ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "v_raton";
  home.homeDirectory = "/home/v_raton";

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "x-scheme-handler/chrome" = "librewolf.desktop";
      "x-scheme-handler/mailto" = "userapp-Thunderbird-NKVW91.desktop";
      "x-scheme-handler/mid" = "userapp-Thunderbird-NKVW91.desktop";
      "x-scheme-handler/news" = "userapp-Thunderbird-V7VX91.desktop";
      "x-scheme-handler/snews" = "userapp-Thunderbird-V7VX91.desktop";
      "x-scheme-handler/nntp" = "userapp-Thunderbird-V7VX91.desktop";
      "x-scheme-handler/feed" = "userapp-Thunderbird-U09X91.desktop";
      "application/rss+xml" = "userapp-Thunderbird-U09X91.desktop";
      "application/x-extension-rss" = "userapp-Thunderbird-U09X91.desktop";
      "x-scheme-handler/webcal" = "userapp-Thunderbird-D7DHA2.desktop";
      "x-scheme-handler/webcals" = "userapp-Thunderbird-D7DHA2.desktop";
      "video/x-matroska" = "smartcode-stremio.desktop";
      "image/png" = "librewolf.desktop";
      "video/mp4" = "mpv.desktop";
      "application/pdf" = "librewolf.desktop";
      "application/x-extension-htm" = "librewolf.desktop";
      "application/x-extension-html" = "librewolf.desktop";
      "application/x-extension-shtml" = "librewolf.desktop";
      "application/xhtml+xml" = "librewolf.desktop";
      "application/x-extension-xhtml" = "librewolf.desktop";
      "application/x-extension-xht" = "librewolf.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
    };
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    devPkgs ++
    [
      pkgs.cava
      pkgs.tmux
      pkgs.scrot
      pkgs.thunderbird
      pkgs.dcnnt
      pkgs.ungoogled-chromium
      pkgs.gimp
      pkgs.insomnia
      pkgs.discord
      pkgs.galaxy-buds-client
      pkgs.stremio
      pkgs.spotify
      pkgs.visidata
      pkgs.obs-studio
      pkgs.helix
      pkgs.pwvucontrol
      pkgs.neofetch
      pkgs.htop
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
    DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = true;
      "identity.fxaccounts.enabled" = true;
    };
  };
}
