{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 10000;
    keyMode = "vi";
    prefix = "C-a";
    escapeTime = 0;
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
    ];

    extraConfig = ''
      # 分屏快捷键
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      # 面板切换（vim 风格）
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
    '';
  };
}
