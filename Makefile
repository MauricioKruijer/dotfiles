# This can be overriden by doing `make DEST=some/path <task>`
DEST = "$(HOME)/.dotfiles"
SRC = "$(DEST)/src"

PREZTO := ~/.zprezto

help:
	@echo Run make install

install:
	 @make install-prezto

install-prezto: 
	$(info --> Install prezto)
	@[[ -d $(PREZTO) ]] || \
		git clone -q --depth 1 --recursive https://github.com/sorin-ionescu/prezto.git $(PREZTO)
	@make configure-prezto change-shell

configure-prezto:
	$(info --> Configure prezto)
	@sh $(SRC)/configure-prezto.sh

change-shell:
	@chsh -s /bin/zsh
