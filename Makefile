.SUFFIXES: .xml .html

OUTDIR = /tmp/xyz

XMLS != find pages -name '*.xml'
HTMLS = $(XMLS:.xml=.html)
FILES != find pages -type f -and ! -name '*.html' -and ! -name '*.xml'

all: $(HTMLS)

install: all
	cp pages/index.html $(OUTDIR)/index.html
	mkdir -p $(OUTDIR)/genealogy/the-tribe-of-benjamin/
	cp the-tribe-of-benjamin.html \
		$(OUTDIR)/genealogy/the-tribe-of-benjamin/index.html
.for h in $(HTMLS)
	mkdir -p $(OUTDIR)/`dirname $h | sed s/pages/./`/`basename $h .html`
	cp $h $(OUTDIR)/`dirname $h | sed s/pages/./`/`basename $h .html`/index.html
.endfor
.for f in $(FILES)
	mkdir -p $(OUTDIR)/`dirname $f | sed s/pages/./`
	cp $f $(OUTDIR)/`dirname $f | sed s/pages/./`
.endfor

.xml.html:
	sblg -c $<
