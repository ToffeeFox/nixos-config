# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./boot.nix

      # Host-Specific Tweaks
      ./hosts/precision_5570/tweaks.nix

      # Load security config
      ./security/core.nix
      ./security/u2f.nix

      # Load special profiles/bundles
      ./profiles/development.nix
      ./browsers/firefox/librewolf/librewolf.nix
    ];

  networking.hostName = "foxpad-ultranix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "@wheel"
    ];
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.

  /*
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
  };
  */

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -A";
      nixup = "sudo nixos-rebuild switch";
    };

    interactiveShellInit = ''
      mkcd() {
        mkdir -p "$@" && cd"$@"
      }
      '';
  };

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      #"ventoy-1.1.12"
    ];
  };

  # Enable Cloudflare WARP
  services.cloudflare-warp = {
    enable = true;
  };

  # Enable Localsend
  # For whatever reason this has to be done via the programs key
  programs.localsend = {
    enable = true;
  };

  programs.steam = {
    enable = false;
  };

  # Define user accounts. Don't forget to set a password with ‘passwd’.
  users.users.saluki = {
    
    isNormalUser = true;
    description = "Sara Grace";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    shell = pkgs.zsh;
  };

  environment.systemPackages = let
    plasma6Enabled = config.services.desktopManager.plasma6.enable;

    # These packages should be installed no matter what
    commonPackages = with pkgs; [
      # CLI Tools
      btop
      inetutils
      pciutils
      tmux

      # GUI Tools
      alacritty
      kdePackages.filelight
      kdePackages.kate
      kdePackages.partitionmanager

      # Dictionaries
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.es_ES # Castillian Spanish
      hunspellDicts.es_MX # Mexican Spanish
      #hunspellDicts.es_ANY # Generic Spanish, non-regional
      #hunspellDicts.ko_KR # Korean

    ];

    qtPackages = with pkgs; [
      libreoffice-qt6-stable
    ];

    gtkPackages = with pkgs; [
      kdePackages.kauth
      kdePackages.kio
      libreoffice-stable
      thunar
    ];

  in
  # Now merge commonPackages with either gtk or qt packages
  commonPackages ++ (if plasma6Enabled then qtPackages else gtkPackages);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "26.05"; # Did you read the comment?

}
