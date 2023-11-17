### grub theme // note slaze theme seems to be not supported anymore
git clone https://github.com/vinceliuice/grub2-themes 
(
    cd grub2-themes
    chmod +x ./install.sh
    sudo ./install.sh --slaze
)
rm -r grub2-themes
