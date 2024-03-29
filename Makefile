#  Makefile for ozmoroz.com Hugo blog web site
#  Dependencies:

DEVD=devd
HUGO=hugo
HUGOOPTS=

BASEDIR=$(CURDIR)
CONFFILE=config.toml
CONTENTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/public
PORT=1313

# SSH of ozmbox1 Degital Ocean box
SSH_HOST="ozmbox1-1"
SSH_PORT=22
SSH_USER=sergey
SSH_TARGET_DIR=/var/www/ozmoroz.com

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	HUGOOPTS += --debug
endif

help:
	@echo 'Makefile for ozmoroz.com Hugo blog website                             '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make clean                       remove the generated files         '
	@echo '   make build\					   biild production site              '
	@echo '   make serve                       serve web site from public directory '
	@echo '   make theme                       build there '
	@echo '   make publish                     publish to ozmoroz.com
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 build_dev'
	@echo '                                                                       '

# Build the web site
build:
	$(HUGO) --cleanDestinationDir \
	--config $(CONFFILE) $(HUGOOPTS) \
	--minify
	#--baseURL $(BASEURL) --contentDir $(CONTENTDIR) --destination $(OUTPUTDIR)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

# Serve Hugo web site with devd, allow CORS for tools such as ngrok
serve:
	$(DEVD) --port=$(PORT) ./public --crossdomain

# Build the theme
theme:
	cd themes/bstrap4; npm run build

publish:
	rsync -e "ssh" --progress -rvzc --checksum --delete \
		$(OUTPUTDIR)/ $(SSH_HOST):$(SSH_TARGET_DIR)
	# Set remote flies permissions
	$(BASEDIR)/publish.sh $(SSH_HOST) $(SSH_TARGET_DIR)


.PHONY: help clean serve publish
