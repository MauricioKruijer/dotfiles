# This can be overriden by doing `make DEST=some/path <task>`
DEST = "$(HOME)/.dotfiles"
SRC = "$(DEST)/src"

PREZTO := ~/.zprezto

OS_SUPPORT = "10.12.[6]"

help:
	@echo Run make install

install:
	@make check-macos-version
	@make install-prezto
	$(info --> Finished! Run chsh -s /bin/zsh)

install-prezto: 
	$(info --> Install prezto)
	@[[ -d $(PREZTO) ]] || \
		git clone -q --depth 1 --recursive https://github.com/sorin-ionescu/prezto.git $(PREZTO)
	@make configure-prezto change-shell

configure-prezto:
	$(info --> Configure prezto)
	@sh $(SRC)/configure-prezto.sh

check-macos-version:
	$(eval OS_VERSION = $(shell defaults read loginwindow SystemVersionStampAsString))
	@echo $(OS_VERSION) | grep -q -E $(OS_SUPPORT) || { echo 'macOS version ($(OS_VERSION)) is not supported'; exit 1; }
	$(info --> macOS version $(OS_VERSION) is supported)
