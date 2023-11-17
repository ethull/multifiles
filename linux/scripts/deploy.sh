# deploy dotfiles

cd ..
CWD=$(pwd)

## create config directories if they dont exist
[ ! -d $HOME/.config ] && mkdir $HOME/.config
### linux config dirs only
[ ! -d $HOME/.local ] && mkdir $HOME/.local
[ ! -d $HOME/.local/bin ] && mkdir $HOME/.local/bin
[ ! -d $HOME/.local/share ] && mkdir $HOME/.local/share
#[ -d $HOME/.local/share/applications ] && rm -r $HOME/.local/share/applications
#ln -sf $CWD/linux/.local/share/applications $HOME/.local/share/applications

## setup program configs

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

### mocp
[ -d $HOME/.moc ] && rm -r $HOME/.moc
ln -sf $CWD/unix/.moc $HOME/.moc

### eclipse vrapper
#[ -d $HOME/.vrapperrc ] && rm -r $HOME/.vrapperrc
#ln -sf $CWD/unix/.vrapperrc $HOME/.vrapperrc

### vifm (linux config)
[ -d $HOME/.config/vifm ] && rm -r $HOME/.config/vifm
ln -sf $CWD/linux/.config/vifm $HOME/.config/vifm

### zathura
#[ -d $HOME/.config/zathura ] && rm -r $HOME/.config/zathura
#ln -sf $CWD/linux/.config/zathura $HOME/.config/zathura

## scripts // just symlink dir?
ln -sf $CWD/linux/.local/bin/pulseaudio_decrease.sh $HOME/.local/bin/pulseaudio_decrease.sh
ln -sf $CWD/linux/.local/bin/pulseaudio_increase.sh $HOME/.local/bin/pulseaudio_increase.sh
ln -sf $CWD/linux/.local/bin/pulseaudio_mute.sh $HOME/.local/bin/pulseaudio_mute.sh

ln -sf $CWD/linux/.local/bin/flac-to-mp3.sh $HOME/.local/bin/flac-to-mp3.sh
ln -sf $CWD/linux/.local/bin/flac-to-mp3-rm.sh $HOME/.local/bin/flac-to-mp3-rm.sh
ln -sf $CWD/linux/.local/bin/flac-to-mp3-rm-recursive.sh $HOME/.local/bin/flac-to-mp3-rm-recursive.sh

## xserver and shell configs
#ln -sf $CWD/.bashrc $HOME/.bashrc
[ -f $HOME/.bash_aliases ] && rm -r $HOME/.bash_aliases
ln -sf $CWD/linux/.bash_aliases $HOME/.bash_aliases
[ -f $HOME/.profile ] && rm -r $HOME/.profile
ln -sf $CWD/linux/.profile $HOME/.profile
[ -f $HOME/.xresources ] && rm -r $HOME/.xresources
ln -sf $CWD/linux/.xresources $HOME/.xresources
[ -f $HOME/.xprofile ] && rm -r $HOME/.xprofile
ln -sf $CWD/linux/.xprofile $HOME/.xprofile
[ -f $HOME/.xinitrc ] && rm -r $HOME/.xinitrc
ln -sf $CWD/linux/.xinitrc $HOME/.xinitrc

## grub config
[ -f /etc/default/grub ] && sudo rm -r /etc/default/grub
sudo cp $CWD/linux/assets/grub /etc/default/grub

## grub theme
sudo cp -r $CWD/linux/assets/grub/slaze /boot/grub/themes/slaze

## gtk theme
sudo cp -r $CWD/linux/assets/themes/Arc-ZenburnPlus /usr/share/themes/Arc-ZenburnPlus
sudo cp -r $CWD/linux/assets/themes/Numix /usr/share/themes/Numix
sudo cp -r $CWD/linux/assets/themes/Midnight-OrangeNight /usr/share/themes/Midnight-OrangeNight

## xfce displays, keybindings, power settings
[ -f $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml ] && rm -r $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/displays.xml $HOME/.config/xfce4/xfce-perchannel-xml/displays.xml
[ -f $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ] && rm -r $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $HOME/.config/xfce4/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
[ -f $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml ] && rm -r $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfce4-power-manager.xml $HOME/.config/xfce4/xfce-perchannel-xml/xfce4-power-manager.xml
