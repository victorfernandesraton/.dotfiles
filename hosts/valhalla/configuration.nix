# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Try to use newer kernel
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # usb
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "valhalla"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable firmware deamon update
  services.fwupd.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Configure keymap in X11
  services.xserver = {
    layout = "us,br";
    xkbVariant = "intl,abnt2";
    displayManager = {
      # for i3
      defaultSession = "none+i3";
      # lightdm.enable = true;
      # for kde
      sddm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3blocks
        feh
        dmenu
        betterlockscreen
        arandr
        cinnamon.nemo
        fd
        gnome-multi-writer
      ];
    };
  };

  # network manager
  programs.nm-applet.enable = false;
  # blueman for bluetooth manager
  services.blueman.enable = true;
  # Configure console keymap
  console.keyMap = "br-abnt2";

  # enable and config zsh
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  # enable opengl
  hardware.opengl.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = false;


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.v_raton = {
    isNormalUser = true;
    description = "v_raton";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" ];
    shell = pkgs.zsh;
  };



  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "v_raton" = import ./home/home.nix;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  # enable old electron for logseq
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    telegram-desktop
    librewolf
    tor
    tor-browser
    neovim
    git
    gcc
    kitty
    glibc
    libvdpau
    xorg.libxcb
    networkmanagerapplet
    vscodium
    discord
  ];

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };

  # bluethooth
  hardware.bluetooth.enable = true;
  # steam
  programs.steam.enable = true;

  virtualisation = {
    # podman
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };

  # Enable experimental-features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # fonts
  fonts.packages = with pkgs; [
    meslo-lgs-nf
  ];


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
