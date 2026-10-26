{ self, inputs, ... }: {
  flake.nixosConfigurations.orion = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [ 
      niri
      hyprlock
      nvim
      alacritty
      tmux
      orionConfiguration
      systemTheme
      core
      audio
      git
      zen-browser
      upower
      sddm
    ];
  };
}
