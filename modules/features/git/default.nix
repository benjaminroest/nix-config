{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.git = moduleWithSystem({self', ...}: {
    programs.git = {
      enable = true;
      package = self'.packages.git;
    };
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;
      runtimePkgs = with pkgs; [
        git-secret
      ];
      settings = {
        user = {
          email = "benjamin9roest@gmail.com";
          name = "benjaminroest";
        };
      };
    };
  };
}

