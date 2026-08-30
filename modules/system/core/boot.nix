{ ... }: {
  flake.nixosModules.bootloader = { pkgs, ... }: {
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;

      loader = {
        systemd-boot.enable = false;
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
          theme = pkgs.minimal-grub-theme;
        };

        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
      };

      kernelParams = [
        "quiet"
        "splash"
        "loglevel=3"
      ];
    };
  };
}
