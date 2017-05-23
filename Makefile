SASSDIR='themes/bootstrap/static/assets/sass'
COMPILEDCSSDIR='themes/bootstrap/static/assets/_css'
S3_BUCKET='waiting-tables.com'

all: clean build push
	# Rebuild pages
	# s3cmd sync --acl-public --delete-removed public/ s3://reformeddeacon.com
	echo "Fail"

build:
	sass $(SASSDIR)/bootstrap.scss:$(COMPILEDCSSDIR)/bootstrap.css $(SASSDIR)/bootstrap-grid.scss:$(COMPILEDCSSDIR)/bootstrap-grid.css $(SASSDIR)/bootstrap-reboot.scss:$(COMPILEDCSSDIR)/bootstrap-reboot.scss

scss:
	sass --watch $(SASSDIR)/bootstrap.scss:$(COMPILEDCSSDIR)/bootstrap.css $(SASSDIR)/bootstrap-grid.scss:$(COMPILEDCSSDIR)/bootstrap-grid.css $(SASSDIR)/bootstrap-reboot.scss:$(COMPILEDCSSDIR)/bootstrap-reboot.css

preview:
	# Launch local server to preview pages (with auto refresh)
	hugo server --watch --port 1313 --buildDrafts --buildFuture --quiet

clean:
	# Delete local build
	rm -rf public

deploy: build
	# Deploy site to heroku
	s3cmd sync --acl-public --delete-removed public/ s3://$(S3_BUCKET)

push:
	# Push to github
	git push

pdfs:
	# Generate PDFs from HTML pages (esp opc.org pages)
	. make_pdfs.sh

archive_pdfs:
	# Archive pdf files from other sites... just in case.
	. archive_pdfs.sh
