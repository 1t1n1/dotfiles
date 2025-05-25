#!/bin/bash
echo -ne "\033[31mWARNING: This installation file has not been tested and is only provided as guide. Have you read it and do you still want to run it? [y/N] \033[0m"
read -n 1 confirmation
if [[ $confirmation == "y" ]]; then
	echo -e "\nInstalling..."
	cd ~/bin
	git clone https://github.com/1t1n1/dotfiles.git
	ln -s ~/bin/dotfiles/.config/alacritty/ ~/.config/
	ln -s ~/bin/dotfiles/.config/dunst/ ~/.config/
	ln -s ~/bin/dotfiles/.config/i3/ ~/.config/
	ln -s ~/bin/dotfiles/.config/picom/ ~/.config/
	ln -s ~/bin/dotfiles/.config/polybar/ ~/.config/
	ln -s ~/bin/dotfiles/.config/rofi/ ~/.config/
	ln -s ~/bin/dotfiles/.config/ranger ~/.config/
	ln -s ~/bin/dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/
	ln -s ~/bin/dotfiles/.config/oh-my-zsh/themes/jonathan.zsh-theme ~/.oh-my-zsh/themes/jonathan.zsh-theme
	ln -s ~/bin/dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/bin/dotfiles/.vim ~/
	sed 's/<your_username>/'$USER'/' ~/bin/dotfiles/etc/vpn/vpn-disconnect.service 
	sed 's/<your_username>/'$USER'/' ~/bin/dotfiles/etc/vpn/vpn-reconnect.service 
	sudo ln -s ~/bin/dotfiles/etc/vpn/vpn-disconnect.service /etc/systemd/system/vpn-disconnect.service
	sudo ln -s ~/bin/dotfiles/etc/vpn/vpn-reconnect.service /etc/systemd/system/vpn-reconnect.service
	# Replace username placeholder of vpn services with your username
	sudo pacman -U pkg/ttf-nerd-fonts-symbols-2048-em-2.3.3-1-any.pkg.tar.zst
	cd bin/vpn/src && make && sudo chown root:root protonvpn_toggler && sudo chmod u+s protonvpn_toggler
	echo "Done."
fi
