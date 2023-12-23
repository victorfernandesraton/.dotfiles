{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    # dotDir = ~/.config/tmux;
    extraConfig = ''

            # Enable RGB (truecolor)
            set -a terminal-features '*:RGB'

            # Enable clored underlines (e.g. in Vim)
            set -a terminal-features '*:usstyle'

            set -ga terminal-overrides ",alacritty:RGB"
            set -ga terminal-overrides ",*256col*:Tc"

            # fix the cursor shape https://github.com/neovim/neovim/issues/5096#issuecomment-469027417
            set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
            # undercurl support
            set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
            # underscore colours - needs tmux-3.0
            set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

            # Use extended keys (CSI u)
            set -g extended-keys on

            ## update the TERM variable of terminal emulator when creating a new session or attaching a existing session
            set -g update-environment 'DISPLAY SSH_ASKPASS SSH_AGENT_PID SSH_CONNECTION WINDOWID XAUTHORITY TERM'
            # use vi mode 
            setw -g mode-keys vi
            bind -T copy-mode-vi v send -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
            bind P paste-buffer
            bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
        '';
  };
}
