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
# SSH_HOST="ozmbox1-1"
# SSH_PORT=22
# SSH_USER=sergey
# SSH_TARGET_DIR=/var/www/ozmoroz.com

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
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 build_dev'
	@echo '                                                                       '

# Build the web site
build:
	$(HUGO) --cleanDestinationDir \
	#--baseURL $(BASEURL) \
	--contentDir $(CONTENTDIR) --destination $(OUTPUTDIR) --config $(CONFFILE) $(HUGOOPTS) \
	--minify

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

# Serve Hugo web site with devd, allow CORS for tools such as ngrok
serve:
	$(DEVD) --port=$(PORT) $(OUTPUTDIR) --crossdomain


.PHONY: help clean serve publish
