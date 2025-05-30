{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
  	vim
	tmux
  	wget
  	git
  	stow
  	lf
  	htop
	distrobox	

   	gnome-software
	ptyxis
  	adwaita-icon-theme
	gnome-themes-extra
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
  
  services.flatpak.enable = true;

  environment.sessionVariables = rec {
	TERM = "ptyxis";
	EDITOR = "vim";
  };

  services.xserver = {
	enable = true;
	displayManager.gdm.enable = true;
	desktopManager.gnome.enable = true;
	excludePackages = [ pkgs.xterm ];
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
    gnome-console
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
