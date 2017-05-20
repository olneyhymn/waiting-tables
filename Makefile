SASSDIR='themes/bootstrap/static/assets/sass'
COMPILEDCSSDIR='themes/bootstrap/static/assets/_css'

all: clean build push
	# Rebuild pages
	# s3cmd sync --acl-public --delete-removed public/ s3://reformeddeacon.com
	echo "Fail"

build:
	hugo --verbose
	sass $(SASSDIR)/bootstrap.scss:$(COMPILEDCSSDIR)/bootstrap.css $(SASSDIR)/bootstrap-grid.scss:$(COMPILEDCSSDIR)/bootstrap-grid.css $(SASSDIR)/bootstrap-reboot.scss:$(COMPILEDCSSDIR)/bootstrap-reboot.scss

scss:
	sass --watch $(SASSDIR)/bootstrap.scss:$(COMPILEDCSSDIR)/bootstrap.css $(SASSDIR)/bootstrap-grid.scss:$(COMPILEDCSSDIR)/bootstrap-grid.css $(SASSDIR)/bootstrap-reboot.scss:$(COMPILEDCSSDIR)/bootstrap-reboot.css

preview:
	# Launch local server to preview pages (with auto refresh)
	hugo server --verbose --watch --port 1313

clean:
	# Delete local build
	rm -rf public

deploy:
	# Deploy site to heroku
	s3cmd sync --acl-public --delete-removed public/ s3://reformeddeacon.com

push:
	# Push to github
	git push

pdfs:
	# Generate PDFs from HTML pages (esp opc.org pages)
	. make_pdfs.sh

archive_pdfs:
	# Archive pdf files from other sites... just in case.
	. archive_pdfs.sh
