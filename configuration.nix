{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  virtualisation.oci-containers.containers = {
   nginx-auto = {
     image = "docker.io/library/nginx:latest";
     autoStart = true;
     ports = [ "81:80" ];
   };
  };

  networking.firewall.allowedTCPPorts = [ 22 80 ];
  services.openssh.enable = true;

  virtualisation.oci-containers.backend = "podman";

  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.enable = true;

  users.users.root = {
    initialPassword = "as";
  };

  environment.systemPackages = with pkgs; [
    vim
    alacritty
    surf
  ];

  system.stateVersion = "24.05";
}
