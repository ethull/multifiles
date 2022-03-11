# deploy dotfiles

cd ..
Path=$(pwd)


## unix
[ ! -d $HOME/.config ] && mkdir $HOME/.config

[ -d $HOME/.vim ] && rm -r $HOME/.vim
ln -sf $Path/unix/.vim $HOME/.vim

[ -d $HOME/.config/nvim ] && rm -r $HOME/.config/nvim
ln -sf $Path/unix/.config/nvim $HOME/.config/nvim

ln -sf $Path/.gitignore_global $HOME/.gitignore_global

#tmux only reads $HOME/.tmux.conf
[ -f $HOME/.tmux.conf ] && rm -r $HOME/.tmux.conf
[ -d $HOME/.config/tmux ] && rm -r $HOME/.config/tmux
ln -sf $Path/unix/.config/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $Path/unix/.config/tmux $HOME/.config/tmux

[ -d $HOME/.moc ] && rm -r $HOME/.moc
ln -sf $Path/unix/.moc $HOME/.moc

#eclipse vrapper config
#[ -d $HOME/.vrapperrc ] && rm -r $HOME/.vrapperrc
#ln -sf $Path/unix/.vrapperrc $HOME/.vrapperrc


## linux
[ -d $HOME/.config/vifm ] && rm -r $HOME/.config/vifm
ln -sf $Path/linux/.config/vifm $HOME/.config/vifm

[ -d $HOME/.config/zathura ] && rm -r $HOME/.config/zathura
ln -sf $Path/linux/.config/zathura $HOME/.config/zathura

[ ! -d $HOME/.local ] && mkdir $HOME/.local
[ ! -d $HOME/.local/bin ] && mkdir $HOME/.local/bin
[ ! -d $HOME/.local/share ] && mkdir $HOME/.local/share
#[ -d $HOME/.local/share/applications ] && rm -r $HOME/.local/share/applications
#ln -sf $Path/linux/.local/share/applications $HOME/.local/share/applications

ln -sf $Path/linux/.local/bin/pulseaudio_decrease.sh $HOME/.local/bin/pulseaudio_decrease.sh
ln -sf $Path/linux/.local/bin/pulseaudio_increase.sh $HOME/.local/bin/pulseaudio_increase.sh

### xserver config
#ln -sf $Path/.bashrc $HOME/.bashrc
[ -f $HOME/.bash_aliases ] && rm -r $HOME/.bash_aliases
ln -sf $Path/linux/.bash_aliases $HOME/.bash_aliases
[ -f $HOME/.profile ] && rm -r $HOME/.profile
ln -sf $Path/linux/.profile $HOME/.profile
[ -f $HOME/.xresources ] && rm -r $HOME/.xresources
ln -sf $Path/linux/.xresources $HOME/.xresources
[ -f $HOME/.xprofile ] && rm -r $HOME/.xprofile
ln -sf $Path/linux/.xprofile $HOME/.xprofile
[ -f $HOME/.xinitrc ] && rm -r $HOME/.xinitrc
ln -sf $Path/linux/.xinitrc $HOME/.xinitrc


## macos
ln -sf $Path/macos/.zshrc $HOME/.zshrc

[ -d $HOME/.config/vifm ] && rm -r $HOME/.config/vifm
ln -sf $Path/macos/.config/vifm $HOME/.config/vifm
