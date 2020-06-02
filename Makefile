APP = io.github.sylvainhalle.textidote
PREFIX ?= ~/

install:
	flatpak-builder --user --install --force-clean ./build ./io.github.sylvainhalle.textidote.yaml
	install -D textidote $(PREFIX)/bin/

build:
	flatpak-builder --force-clean ./build ./io.github.sylvainhalle.textidote.yaml

clean:
	-$(RM) -r build
