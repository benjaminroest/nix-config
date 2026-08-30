{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.hyprlock = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      hyprlock
    ];
  });
  perSystem = {pkgs, ...}: {
    packages.hyprlock = inputs.wrappers.wrappers.hyprlock.wrap {
      inherit pkgs;
      settings = {
        general = {
          grace = 5;
          hide_cursor = true;
          ignore_empty_input = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
          }
        ];
      };
    };
  };
}

