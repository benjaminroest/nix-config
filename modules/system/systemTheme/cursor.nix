{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cursor = {
    pkgs,
    lib,
    ...
  }: let
  in {
    environment.systemPackages = with pkgs; [
      bibata-cursors
    ];

    environment.variables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "20";
    };
  };
}
