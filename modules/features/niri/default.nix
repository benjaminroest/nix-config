{ inputs, moduleWithSystem, ...  }: {
  flake.nixosModules.niri = moduleWithSystem (
    {self'}: {
      #environment.systemPackages = with self'.packages; [
      #  niri
      #];
      programs.niri = {
        enable = true;
        package = self'.packages.niri;
      };
      services.displayManager.defaultSession = "niri";
      services.xserver.enable = true;
    }
  );
  perSystem = {pkgs, ...}: {
    packages.niri = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        prefer-no-csd = _: { };
        cursor = {
         xcursor-theme = "Bibata-Modern-Ice";
         xcursor-size = 24;
        };
        input = {
          focus-follows-mouse = _: { };

          keyboard = {
            numlock = _: { };
          };

          touchpad = {
            tap = _: { };
            natural-scroll = _: { };
          };
          
          mouse = {
            accel-profile = "flat";
          };
        };
        outputs = {
         "HDMI-A-2" = {
            position = _: {
              props = {
                x = -1080;
                y = 0;
              };
            };
            mode = "2560x1440@59.951";
            scale = 1;
          };
        };
        hotkey-overlay = {
          skip-at-startup = _: {};
        };
        binds = {
          "Mod+W".close-window = _: { };
          "Mod+F".maximize-column = _: { };

          "Mod+Left".focus-column-left   = _: { };
          "Mod+Right".focus-column-right = _: { };
          "Mod+Up".focus-window-up       = _: { };
          "Mod+Down".focus-window-down   = _: { };

          "Mod+H".focus-column-left  = _: { };
          "Mod+L".focus-column-right = _: { };
          "Mod+K".focus-window-up    = _: { };
          "Mod+J".focus-window-down  = _: { };

          "Mod+Shift+Left".move-column-left   = _: { };
          "Mod+Shift+Right".move-column-right = _: { };
          "Mod+Shift+Up".move-window-up       = _: { };
          "Mod+Shift+Down".move-window-down   = _: { };

          "Mod+Shift+H".move-column-left  = _: { };
          "Mod+Shift+L".move-column-right = _: { };
          "Mod+Shift+K".move-window-up    = _: { };
          "Mod+Shift+J".move-window-down  = _: { };

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          "Mod+BracketLeft".consume-or-expel-window-left = _: { };
          "Mod+BracketRight".consume-or-expel-window-right = _: { };

          "Print".screenshot = _: { };
          "Mod+Print".screenshot-window = _: { };
          "Mod+Shift+Print".screenshot-screen = _: { };

          "Mod+Shift+Slash".show-hotkey-overlay = _: { };
          "Mod+Shift+q".quit = _: { };
          "Mod+Alt+L".spawn = "hyprlock";

          "Mod+Return".spawn = "alacritty";
          "Mod+B".spawn = "zen";
        };
      };
    };
  };
}

