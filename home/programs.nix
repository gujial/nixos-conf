_: {
  programs.zsh = {
    enable = true;
    initContent = ''
      if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
        tmux new-session -A -s default
        exit
      fi
    '';
  };
}
