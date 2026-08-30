{ self, inputs, ...}: {
  flake.nixosModules.network = {
    pkgs,
    lib,
    ...
  }: {
    networking = {
      networkmanager = {
        enable = true;
      };
      firewall.enable = false;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
