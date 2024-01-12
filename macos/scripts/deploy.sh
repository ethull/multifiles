# deploy dotfiles

cd ..
CWD=$(pwd)

## create config directories if they dont exist
[ ! -d $HOME/.config ] && mkdir $HOME/.config

## setup program configs

### vscode
[ -f "$HOME/Library/Application Support/Code/User/settings.json" ] && rm -r "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf $CWD/unix/.vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

/Users/L014141/Library/Application Support/Code/User/settings.json
/Users/L014141/Projects/mac-setup/multifiles/unix/.vscode/settings.json

### vim
[ -d $HOME/.vim ] && rm -r $HOME/.vim
ln -sf $CWD/unix/.vim $HOME/.vim

### nvim
[ -d $HOME/.config/nvim ] && rm -r $HOME/.config/nvim
ln -sf $CWD/unix/.config/nvim $HOME/.config/nvim

### git
ln -sf $CWD/.gitignore_global $HOME/.gitignore_global

### tmux
#tmux only reads $HOME/.tmux.conf
[ -f $HOME/.tmux.conf ] && rm -r $HOME/.tmux.conf
[ -d $HOME/.config/tmux ] && rm -r $HOME/.config/tmux
ln -sf $CWD/unix/.config/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $CWD/unix/.config/tmux $HOME/.config/tmux

### vifm (macos config)
[ -d $HOME/.config/vifm ] && rm -r $HOME/.config/vifm
ln -sf $CWD/macos/.config/vifm $HOME/.config/vifm

## scripts // just symlink dir?

## shell configs // add macos setup script?
#[ -f $HOME/.zshrc ] && rm -r $HOME/.zshrc
ln -sf $CWD/macos/.zshrc $HOME/.zshrc
#zprofile?
#[ -f $HOME/.profile ] && rm -r $HOME/.profile
#ln -sf $CWD/linux/.profile $HOME/.profile
