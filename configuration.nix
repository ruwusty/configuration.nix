# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Allow propietary packages or else you cant install shit
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# i still cant get grub to detect windows >:c angy moment
boot.supportedFilesystems = [ "ntfs" ];

boot.loader.systemd-boot.enable = false;
boot.loader.grub.enable = true;
boot.loader.grub.version = 2;
boot.loader.grub.useOSProber = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.device = "/dev/nvme0n1"; 


  networking.hostName = "rusty"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

# enable gnome displaymanager and add awesome as a desktop environment
services.xserver.displayManager = {
  gdm.enable = true;
  defaultSession = "none+awesome";
};

#enable awesomewm and install lua packages
services.xserver.windowManager.awesome = {
  enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks
      luadbi-mysql  
  ];
};

# enable gnome as a fallback bcs awesome is brok rn
services.xserver.desktopManager = {
  gnome.enable = true;
};

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rusty = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    firefox
    vscode
    pkgs.xfce.thunar # thunar on top
    kitty # kitty on top
    pcmanfm # thunar is still better but pcmanfm is respectable
    discord
    picom
    grub2_efi
    ntfs3g
    rofi
    zsh # zsh is superior
    oh-my-zsh # yes
    meslo-lg
    shutter
    beauty-line-icon-theme # these icons are cool
    sweet
    spotify
    git
    gparted
    os-prober # why wont u work properly
    etcher
    awesome # ur still broken L
    pkgs.gnome.gnome-tweaks # needed to make gnome pleasing to look at
    pkgs.gnome.gnome-shell-extensions # needed to make gnome pleasing to look at
    neofetch
    orchis
    orchis-theme
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk
    noto-fonts-emoji
    open-sans
    font-manager
  ];

# set zsh as default shell 
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;

# window transparancy (currently only works on awesomewm)
services.picom = {
  enable = true;
  fade = true;
  inactiveOpacity = 0.9;
  shadow = true;
  fadeDelta = 4;
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "21.11"; # Did you read the comment?

}

