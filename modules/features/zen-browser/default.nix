{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zen-browser = moduleWithSystem ({ self', ... }: {
    environment.systemPackages = [
      self'.packages.zen-browser
    ];
  });

  perSystem = {
    pkgs,
    lib,
    self',
    inputs',
    ...
  }: {
    packages = {
      zen-browser = pkgs.wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList
              (name: value:
                ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
              )
              {
                "extensions.autoDisableScopes" = 0;
                "extensions.pocket.enabled" = false;
              }
          );

          extraPolicies = {
            DisableTelemetry = true;

            ExtensionSettings = {
                "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                  install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                  installation_mode = "normal_installed";
                  private_browsing = true;
                };
               "uBlock0@raymondhill.net" = {
                  install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/ublock-origin/latest.xpi";
                  installation_mode = "normal_installed";
                  private_browsing = true;
                };
               "sponsorBlocker@ajay.app" = {
                  install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/sponsorblock/latest.xpi";
                  installation_mode = "normal_installed";
                  private_browsing = true;
                };
            };

            SearchEngines = {
              Default = "ddg";

              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate =
                    "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate =
                    "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate =
                    "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
              ];
            };
          };
        };
    };
  };
}
