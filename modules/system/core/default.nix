{ self, inputs, ...}: {
  flake.nixosModules.core = {
    pkgs,
    lib,
    ...
  }: let
    modules = with self.nixosModules; [
      bootloader
      locale
      user
      nix
      network
    ];
  in {
    imports = 
      [
        /etc/nixos/hardware-configuration.nix
      ]
      ++ modules;
    services = {
      openssh.enable = true;
    };
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
    system.stateVersion = "26.05";
  };
}
