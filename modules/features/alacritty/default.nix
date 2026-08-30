{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
    flake.nixosModules.alacritty = moduleWithSystem (
    {self'}: {
      environment.systemPackages = with self'.packages; [
        alacritty
      ];
    }
  );

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.alacritty = let
      monaspace = pkgs.nerd-fonts.monaspace;
      fontsConf = pkgs.makeFontsConf {
        fontDirectories = [monaspace];
      };
    in inputs.wrappers.wrappers.alacritty.wrap {
      inherit pkgs;
      settings = {
        env = {
          "FONTCONFIG_FILE" = "${fontsConf}";
        };
        font = {
          size = 13;
          normal = {
            family = "MonaspiceNe Nerd Font Mono";
          };
          italic = {
            family = "MonaspiceRn Nerd Font Mono";
          };
        };
        cursor.style.blinking = "On";
      };
    };
  };
}

