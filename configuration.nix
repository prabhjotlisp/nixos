{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
  	vim git wget
  	htop lf
  	distrobox	
  	gnome-backgrounds
  ];

  fonts.packages = with pkgs; [ hack-font ];

  virtualisation.podman = {
  	enable = true;
  	dockerCompat = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ###############
  ### System ####
  ###############

  environment.shellAliases = {
	update = "sh -c /home/babu/.config/nixos/update.sh";
	update-commit = "sh -c /home/babu/.config/nixos/update-commit.sh";
	edit = "gnome-text-editor";
  };

  services.xserver = {
	enable = true;
	displayManager.gdm.enable = true;
	desktopManager.gnome.enable = true;
	excludePackages = [ pkgs.xterm ];
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          # "org/gnome/desktop/interface" = {
            # clock-format = "12h";
            # show-battery-percentage = true;
            # color-scheme = "prefer-dark";
            # accent-color = "red";
          # };
          "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-type = "nothing";
            sleep-inactive-battery-type = "nothing";
          };
          # "org/gnome/desktop/wm/keybindings" = {
          #   move-to-workspace-left = "['<Shift><Super>u']";
          #   move-to-workspace-right = "['<Shift><Super>i']";
          #   switch-to-workspace-left = "['<Super>u']";
          #   switch-to-workspace-right = "['<Super>i']";
          #   toggle-fullscreen = "['<Super>f']";
          #   toggle-maximized = "['<Super>space']";
          # };
        };
      }
    ];
  };

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-disk-utility
    gnome-backgrounds
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    baobab
    epiphany
    # gnome-text-editor
    # gnome-calculator
    # gnome-calendar
    gnome-characters
    # gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    # gnome-music
    # gnome-weather
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    # gnome-software
  ];

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support 
  services.libinput.enable = true;

  # User
  users.users.babu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "podman"];
  };

  # power management
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  # enabel opengl and graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  # disable sleep on lead close
  services.logind.extraConfig = ''
  	HandleLidSwitch=ignore
  	HandleLidSwitchExternalPower=ignore
  	HandleLidSwitchDocked=ignore
  '';

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  # don't touch
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05"; # Did you read the comment?
}
