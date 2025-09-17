# https://github.com/tmux-plugins/tmux-pain-control/blob/master/pain_control.tmux

## prefix unbind C-b
set -g prefix `
bind ` send-prefix

#todo figure out how to change to copy mode without mouse
# bind-key -T root C-m if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= \"#{pane_in_mode}\" \"send-keys -M\" \"copy-mode -et=\""

## panes/windows
### split/create panes/windows
bind-key "c" new-window -c "#{pane_current_path}"
bind-key "%" split-window -h -c "#{pane_current_path}"
bind-key '"' split-window -v -c "#{pane_current_path}"

bind-key "\\" split-window -fh -c "#{pane_current_path}"
bind-key "_" split-window -fv -c "#{pane_current_path}"
### resize panes
# can use these raw but i map them to shift-ctrl-<h,j,k,l> in iterm.
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
### change pane
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind-key C-h select-pane -L
bind-key C-j select-pane -D
bind-key C-k select-pane -U
bind-key C-l select-pane -R
### x closes panes, & closes windows so I changed to X
unbind &
bind X confirm-before -p "kill-window #W? (y/n)" kill-window
### mv a window
bind-key -r "<" swap-window -d -t -1
bind-key -r ">" swap-window -d -t +1

# easy config reloads
bind r source-file ~/.tmux.conf \; display-message "Config Reloaded!"


# vim

## vi style keys
# Use vi keybindings for tmux commandline input.
# Note that to get command mode you need to hit ESC twice...
set -g status-keys vi
# Use vi keybindings in copy and choice modes
setw -g mode-keys vi

## vim selection for copy-mode
unbind [
bind Escape copy-mode
unbind p
bind p paste-buffer

# yank to global clipboard without exiting copy-mode
bind -T copy-mode-vi v send -X begin-selection
# macOS uses pbcopy, Linux uses xclip/xsel
if-shell 'uname | grep -q Darwin' \
  "bind -T copy-mode-vi y send -X copy-pipe 'pbcopy'" \
  "bind -T copy-mode-vi y send -X copy-pipe 'xclip -selection clipboard -in'"

# also make enter behave the same way
if-shell 'uname | grep -q Darwin' \
  "bind -T copy-mode-vi Enter send -X copy-pipe 'pbcopy'" \
  "bind -T copy-mode-vi Enter send -X copy-pipe 'xclip -selection clipboard -in'"

# mouse drag → copy to clipboard, stay in copy-mode
if-shell 'uname | grep -q Darwin' \
  "bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe 'pbcopy'" \
  "bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe 'xclip -selection clipboard -in'"


## plugins keys 
set -g @jump-key 'g'
set -g @urlview-key 'b'
#jump-key unmaps s regardless, remap it back to default
bind-key s choose-tree -Zs
# tmux-fzf: F
set -g @resurrect-save 'S'
set -g @resurrect-restore 'R'

# easily toggle synchronization (mnemonic: e is for echo)
# sends input to all panes in a given window.
bind e setw synchronize-panes on
bind E setw synchronize-panes off

## old
#unbind '"'
#unbind %
#bind s split-window -c "#{pane_current_path}"
#bind v split-window -h -c "#{pane_current_path}"
#bind t new-window -c "#{pane_current_path}"

# moved from s (for new horizontal split)
# bind '"' choose-tree -Zs
# moved from w (for new window)
# bind c choose-tree -Zw

