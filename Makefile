TFMFILES=yhcmex10.tfm yrcmex10.tfm
VFFILES=yhcmex10.vf
MFFILES=yhbigacc.mf yhbigdel.mf yhmathex.mf yrcmex10.mf
VPLFILES=yhcmex10.vpl
TEXFILES=OMXyhex.fd yhmath.sty
MAPFILES=yhmath.map
DOCFILES=yhmath.pdf
DRVFILES=yhmath.drv

PFBFILES=yhcmex.pfb
SOURCEFILES=yhmath.dtx yhmath.ins

GENFILES=$(TFMFILES) $(VFFILES) $(MFFILES) $(VPLFILES) $(TEXFILES) $(MAPFILES) $(DOCFILES) $(DRVFILES)

DESTDIR ?= /usr/local/share/texmf
CLEANRM ?= :

all: $(GENFILES)

install: $(TFMFILES) $(VFFILES) $(MFFILES) $(TEXFILES) $(MAPFILES) $(DOCFILES) $(PFBFILES) $(SOURCEFILES)
	mkdir -p $(DESTDIR)/fonts/tfm/public/yhmath
	$(CLEANRM) $(DESTDIR)/fonts/tfm/public/yhmath/*
	cp $(TFMFILES) $(DESTDIR)/fonts/tfm/public/yhmath
	#
	mkdir -p $(DESTDIR)/fonts/vf/public/yhmath
	$(CLEANRM) $(DESTDIR)/fonts/vf/public/yhmath/*
	cp $(VFFILES) $(DESTDIR)/fonts/vf/public/yhmath
	#
	mkdir -p $(DESTDIR)/fonts/source/public/yhmath
	$(CLEANRM) $(DESTDIR)/fonts/source/public/yhmath/*
	cp $(MFFILES) $(DESTDIR)/fonts/source/public/yhmath
	#
	mkdir -p $(DESTDIR)/fonts/type1/public/yhmath
	$(CLEANRM) $(DESTDIR)/fonts/type1/public/yhmath/*
	cp $(PFBFILES) $(DESTDIR)/fonts/type1/public/yhmath
	#
	mkdir -p $(DESTDIR)/fonts/map/dvips/yhmath
	$(CLEANRM) $(DESTDIR)/fonts/map/dvips/yhmath/*
	cp $(MAPFILES) $(DESTDIR)/fonts/map/dvips/yhmath
	#
	mkdir -p $(DESTDIR)/tex/latex/yhmath
	$(CLEANRM) $(DESTDIR)/tex/latex/yhmath/*
	cp $(TEXFILES) $(DESTDIR)/tex/latex/yhmath
	#
	mkdir -p $(DESTDIR)/doc/latex/yhmath
	$(CLEANRM) $(DESTDIR)/doc/latex/yhmath/*
	cp $(DOCFILES) $(DESTDIR)/doc/latex/yhmath
	#
	mkdir -p $(DESTDIR)/source/latex/yhmath
	$(CLEANRM) $(DESTDIR)/source/latex/yhmath/*
	cp $(SOURCEFILES) $(DESTDIR)/source/latex/yhmath
	#
	mktexlsr $(DESTDIR)



$(MFFILES) $(VPLFILES) $(TEXFILES) $(MAPFILES) $(DRVFILES): $(SOURCEFILES)
	latex yhmath.ins

yhmath.pdf: yhmath.drv
	pdflatex yhmath.drv
	pdflatex yhmath.drv

yrcmex10.tfm: $(MFFILES)
	mktextfm --destdir `pwd` yrcmex10
	rm -f yrcmex10.*pk

yhcmex10.tfm yhcmex10.vf: yhcmex10.vpl
	vptovf yhcmex10.vpl

clean:
	-rm -f $(VPLFILES) yrcmex10.*pk yhmath.log yhmath.aux yhmath.drv
	-rm -f yrcmex10.log
	-rm -f *~



distclean: clean
	-rm -f $(GENFILES)
