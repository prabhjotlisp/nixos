{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "linux"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Fire Wall
  networking.firewall = {
  	enable = true;
	allowedTCPPorts = [ 8080 8081 8000 ];
	# allowedUDPPortRanges = [
	# 	{ from = 8000; to = 8100; }
	# ];
  };
 

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";


#####################################


  # Graphics
  hardware = {
    graphics = {
        enable = true;
        enable32Bit = true;
    };

    amdgpu.amdvlk = {
        enable = true;
        support32Bit.enable = true;
    };
  };

  # Enable sound.
  services.pipewire = {
  	enable = true;
        pulse.enable = true;
  };

  # Virt Manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["babu"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # DistroBox
  virtualisation.podman = {
  	enable = true;
  	dockerCompat = true;
  };
  
  # Steam 
  programs.steam.enable = true;

  # LibInput
  services.libinput.enable = true;

  # Kanata
  # services.kanata.enable = true;
  # services.kanata.keyboards.laptop.configFile = /home/babu/.config/kanata/config.kbd;

  # User
  users.users.babu = {
  	isNormalUser = true;
  	extraGroups = [ "wheel" "libvirtd" "podman" ];
#	subGidRanges = [
#        	{ count = 65536; startGid = 1000; }
#      	];
#      	subUidRanges = [
#        	{ count = 65536; startUid = 1000; }
#      	];
   };

  # Fonts
  fonts.packages = with pkgs; [
     hack-font
  ];

  # Programs
  programs.firefox.enable = true;
  programs.sway.enable = true;

  # nix flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # wayland in electrone and chrommium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Shell Aliases
  environment.shellAliases = {
	l = "ls -lh";
	ll = "ls -alh";
	my-rebuild = "sudo nixos-rebuild switch --flake /etc/nixos/#default";
  };

  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
	### cmd tools
	vim
	wget
	htop
	lf
	git
	stow
	brightnessctl
	gammastep
	distrobox
	podman-compose
	semgrep

	### devlopment
	vscode-extensions.llvm-vs-code-extensions.vscode-clangd
	vscodium-fhs
	# vscode
	helix

	### lsps
	libclang
	lldb
	rust-analyzer
	typescript-language-server

	### gui apps
	(chromium.override {
      		commandLineArgs = [
        	"--enable-features=AcceleratedVideoEncoder"
        	"--ignore-gpu-blocklist"
        	"--enable-zero-copy"
      		];
    	})
	tor-browser
	rofi-wayland
	alacritty
	emacs-gtk
  ];

  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
  system.stateVersion = "24.11"; # Did you read the comment?
}

