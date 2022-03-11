### desgin changes

# window style
#set inactive/active window styles
#set -g window-style 'fg=colour247,bg=colour236'
#set -g window-active-style 'fg=colour250,bg=black'
# }

# window status {
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
setw -g window-status-current-style fg=colour81
setw -g window-status-current-style bg=colour238
setw -g window-status-current-style bold
setw -g window-status-style fg=colour138
setw -g window-status-style bg=colour235
setw -g window-status-style none
setw -g window-status-bell-style fg=colour255
setw -g window-status-bell-style bg=colour1
setw -g window-status-bell-style bold
# }

# Info on left (I don't have a session display for now)
set -g status-left ''

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

set -g default-terminal "screen-256color"

# The modes {
setw -g clock-mode-colour colour135
#window mode
setw -g mode-style fg=colour196
setw -g mode-style bg=colour238
setw -g mode-style bold
# }

# The panes {
set -g pane-border-style bg=colour239
set -g pane-border-style fg=colour238
set -g pane-active-border-style bg=colour236
set -g pane-active-border-style fg=colour2
#set -g pane-border-style fg=black
#set -g pane-active-border fg=brightred
# }

# The statusbar {
set -g status-position bottom
set -g status-style bg=colour234
set -g status-style fg=colour137
set -g status-style dim 
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour245,bold] %A %-I:%M #[fg=colour255,bg=colour000] #(whoami)@#H'
set -g status-right-length 50
set -g status-left-length 20
set -g status-justify left
set -g status-interval 2
#set -g status-utf8 on
# }

# The messages {
set -g message-style fg=colour232
set -g message-style bg=colour166
set -g message-style bold
set -g message-command-style fg=blue
set -g message-command-style bg=black
# }
