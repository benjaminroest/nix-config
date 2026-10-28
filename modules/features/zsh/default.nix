{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zsh = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    nixpkgs.overlays = [
      (final: prev: {
        zsh = self'.packages.zsh;
      })
    ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 10000;
    };
    users.defaultUserShell = pkgs.zsh;
  });
  perSystem = {
    pkgs,
    self',
    lib,
    ...
  }: {
    packages = {
      zsh = let
        flakeLocation = builtins.getEnv "PWD";
      in 
        lib.warnIf (flakeLocation == "") "Flake Location is undefined. Are you building in the right directory?"
        inputs.wrappers.wrappers.zsh.wrap {
          inherit pkgs;
          runtimePkgs = [
            pkgs.fzf 
            pkgs.starship
            pkgs.fd
            pkgs.lazygit

            pkgs.zsh-autosuggestions
            pkgs.zsh-history-substring-search
            pkgs.zsh-vi-mode
            pkgs.zsh-fast-syntax-highlighting
          ];
          zshAliases = {
            ls = "${lib.getExe pkgs.lsd}";
            ll = "${lib.getExe pkgs.lsd} -l";
            la = "${lib.getExe pkgs.lsd} -la";
            lg = lib.getExe pkgs.lazygit;
            man = "man -P \"${lib.getExe pkgs.bat} -p\"";
            nsh = "nix-shell -p";
            nrs =
              if flakeLocation != ""
                then "( cd ${flakeLocation} && sudo nixos-rebuild switch --impure --flake . )"
              else "echo 'Flake location not specified. Did you build with --impure?'";
            vinix =
              if flakeLocation != ""
                then "nvim --cmd 'cd ${flakeLocation}'"
              else "echo 'Flake location not specified. Did you build with --impure?'";
          };
          zshrc.content = ''
            # Load machine-specific configuration if present
            if [[ -f "$HOME/.config/zsh/local.zsh" ]]; then
              source "$HOME/.config/zsh/local.zsh"
            fi

            if command -v nvim >/dev/null 2>&1; then
              alias v="nvim"
              alias vim="nvim"
            fi

            export STARSHIP_CONFIG="${./starship.toml}"
            eval "$(${lib.getExe pkgs.starship} init zsh)"
            

            source "${./defaults.zsh}"
            source "${./completion.zsh}"
            source "${./fzf.zsh}"
            source "${./git.zsh}"
            source "${./bindings.zsh}"

            # Always start each new prompt in insert mode
            ZVM_LINE_INIT_MODE=i

            # Plugins
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
            source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

            source <(${lib.getExe pkgs.fzf} --zsh)
            '';
      };
    };
  };
}

