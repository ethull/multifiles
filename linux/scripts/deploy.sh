# deploy dotfiles

create_dir () {
  TARGET_PATH=$1
  [ ! -d $TARGET_PATH ] && mkdir $TARGET_PATH
}

refresh_dir () {
  TARGET_PATH=$1
  [ -d $TARGET_PATH ] && rm -r $TARGET_PATH
}

refresh_file () {
  TARGET_PATH=$1
[ -f $TARGET_PATH ] && rm -r $TARGET_PATH
}

cd ..
CWD=$(pwd)

## create config directories if they dont exist
create_dir $HOME/.config
### linux config dirs only
create_dir $HOME/.local
create_dir $HOME/.local/bin
create_dir $HOME/.local/share
#refresh_dir $HOME/.local/share/applications
#ln -sf $CWD/linux/.local/share/applications $HOME/.local/share/applications

## setup program configs

### vim
refresh_dir $HOME/.vim
ln -sf $CWD/unix/.vim $HOME/.vim

### nvim
refresh_dir $HOME/.config/nvim
ln -sf $CWD/unix/.config/nvim $HOME/.config/nvim

### git
ln -sf $CWD/.gitignore_global $HOME/.gitignore_global

### tmux
#tmux only reads $HOME/.tmux.conf
refresh_file $HOME/.tmux.conf
refresh_dir $HOME/.config/tmux
ln -sf $CWD/unix/.config/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $CWD/unix/.config/tmux $HOME/.config/tmux

### mocp
refresh_dir $HOME/.moc
ln -sf $CWD/unix/.moc $HOME/.moc

### eclipse vrapper
#refresh_file $HOME/.vrapperrc
#ln -sf $CWD/unix/.vrapperrc $HOME/.vrapperrc

### vifm (linux config)
refresh_dir $HOME/.config/vifm
ln -sf $CWD/linux/.config/vifm $HOME/.config/vifm

### zathura
refresh_dir $HOME/.config/zathura
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
refresh_file $HOME/.bash_aliases
ln -sf $CWD/linux/.bash_aliases $HOME/.bash_aliases
refresh_file $HOME/.profile
ln -sf $CWD/linux/.profile $HOME/.profile
refresh_file $HOME/.xresources
ln -sf $CWD/linux/.xresources $HOME/.xresources
refresh_file $HOME/.xprofile
ln -sf $CWD/linux/.xprofile $HOME/.xprofile
refresh_file $HOME/.xinitrc
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

## xfce displays, keybindings, power settings, win manager, xsettings (gtk theme)
refresh_file $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/displays.xml $HOME/.config/xfce4/xfce-perchannel-xml/displays.xml
refresh_file $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml $HOME/.config/xfce4/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
refresh_file $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfce4-power-manager.xml $HOME/.config/xfce4/xfce-perchannel-xml/xfce4-power-manager.xml
refresh_file $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfwm4.xml $HOME/.config/xfce4/xfce-perchannel-xml/xfwm4.xml
refresh_file $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
ln -sf $CWD/linux/.config/xfce4/xfce-perchannel-xml/xfwm4.xml $HOME/.config/xfce4/xfce-perchannel-xml/xsettings.xml
