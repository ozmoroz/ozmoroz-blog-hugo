#  Makefile for ozmoroz.com Hugo blog web site
#  Dependencies:
#  brotli (brew install brotli)
#  devd (https://github.com/cortesi/devd/)
#  minify (https://github.com/tdewolff/minify/tree/master/cmd/minify)
#  ngrok (https://ngrok.com)

BROTLI=/usr/local/bin/brotli
DEVD=devd
HUGO=hugo
HUGOOPTS=

BASEDIR=$(CURDIR)
CONFFILE=config.toml
CONTENTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/public
THEMEDIR=$(BASEDIR)/themes/hugo-theme-bootstrap4-ozmoroz
PORT=1313

# SSH of ozmbox1 Degital Ocean box
SSH_HOST="ozmbox1-1"
#SSH_PORT=22
#SSH_USER=sergey
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
	@echo '   make build_dev                   build dev site (w/o minification)  '
	@echo '   make build_prod                  build prod site (with minification) '
	@echo '   make serve                       serve web site from public directory '
	@echo '   make publish                     publish to ozmoroz.com             '
	@echo '                                                                       '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 build_dev'
	@echo '                                                                       '

# Build the web site
build:
	$(HUGO) --cleanDestinationDir \
	--baseURL $(BASEURL) \
	--contentDir $(CONTENTDIR) --destination $(OUTPUTDIR) --config $(CONFFILE) $(HUGOOPTS)

# Build a development website (without minification or compression)
build_dev: BASEURL=http://localhost:$(PORT)/
build_dev: build

# Build a production website (with minimication and compression)
build_prod: BASEURL=https://ozmoroz.com/
build_prod: clean build minify compress

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

compress:
	# Precompress all the minified files, so caddy can serve pre-compressed files
	# without having to compress on the fly, leading to zero-CPU static file
	# serving.

	echo "- Compressing gzip"
	find $(OUTPUTDIR) -type f \( -name '*.html' -o -name '*.js' -o -name '*.css' -o -name '*.xml' -o -name '*.svg' \) \
	-exec gzip -k -v -f -9 {} \;

	echo "- Compressing brotli"
	find $(OUTPUTDIR) -type f \( -name '*.html' -o -name '*.js' -o -name '*.css' -o -name '*.xml' -o -name '*.svg' \) \
	-exec $(BROTLI) --keep --quality=11 {} \;

# Minify HTML files
minify:
	minify -r -o $(OUTPUTDIR) --match=\.html $(OUTPUTDIR)

# Serve Hugo seb site with devd, allow CORS for tools such as ngrok
serve:
	$(DEVD) --port=$(PORT) $(OUTPUTDIR) --crossdomain


publish:
	rsync -e "ssh" --progress -rvzc --checksum --delete \
		$(OUTPUTDIR)/ $(SSH_HOST):$(SSH_TARGET_DIR)
	$(BASEDIR)/publish.sh $(SSH_HOST) $(SSH_TARGET_DIR)

.PHONY: help clean build_dev build_prod compress minify serve publish
