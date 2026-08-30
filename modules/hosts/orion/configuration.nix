{ self, inputs, ... }: {
  flake.nixosModules.orionConfiguration = { pkgs, ... }: {
    networking = {
      hostName = "Orion";
    };
  };
}
