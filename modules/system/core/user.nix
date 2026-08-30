{ self, inputs, ...}: {
  flake.nixosModules.user = { pkgs, lib, ... }: {
    users.users.benjamin = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
}
