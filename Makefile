all:
	for i in $$(ls | grep -vf .stow-local-ignore ) ; do stow --verbose  --dotfiles $$i;  done  

delete:
	stow --verbose --target=$$HOME --delete */
