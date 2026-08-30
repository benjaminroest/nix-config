{ inputs, ... }: {
  flake.nixosModules.nix = {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };

      optimise.automatic = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}