{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
    flake.nixosModules.tmux = moduleWithSystem (
    {self'}: {
      environment.systemPackages = with self'.packages; [
        tmux
      ];
    }
  );

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.tmux = inputs.wrappers.wrappers.tmux.wrap {
      inherit pkgs;
      terminal = "tmux-256color";
      terminalOverrides = ",xterm*:Tc";

      configAfter = ''
        set -g renumber-windows on
        set -g status-position top

        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" \
          "send-keys -M" \
          "if -Ft= '#{pane_in_mode}' 'send-keys -M' \
          'select-pane -t=; copy-mode -e; send-keys -M'"

        bind -n WheelDownPane \
          select-pane -t= \; send-keys -M

        bind -n C-WheelUpPane \
          select-pane -t= \; copy-mode -e \; send-keys -M

        bind -T copy-mode-vi C-WheelUpPane \
          send-keys -X halfpage-up

        bind -T copy-mode-vi C-WheelDownPane \
          send-keys -X halfpage-down

        bind -T copy-mode-emacs C-WheelUpPane \
          send-keys -X halfpage-up

        bind -T copy-mode-emacs C-WheelDownPane \
          send-keys -X halfpage-down

        set -g status-interval 1
        set -g status-bg "#171B20"
        set -g status-fg "#E7EAEE"
        set -g status-justify left

        set -g status-left-length 100
        set -g status-left-style "bg=#38FFA5,fg=#171B20"
        set -g status-left " #S "

        set -g status-right-style "bg=#5CCEFF,fg=#171B20"
        set -g status-right-length 102
        set -g status-right \
          " #{?#{pane_ssh_connected},#U @ #H#[default],local} "

        set -g window-status-separator ""
        set -g window-status-format "  #W  "
        set -g window-status-current-format "  #W  "

        set -g window-status-current-style \
          "fg=#E7EAEE,bg=#171B20,bold"

        set -g window-status-style \
          "fg=#586172,bg=#171B20"

        set -g status on
      '';
    };
  };
}

