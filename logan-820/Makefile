

SOURCES = $(wildcard *.scad)


OPENSCAD = openscad
ADMESH = admesh


default: all


all: $(SOURCES:.scad=.stl)


clean:
	$(RM) *.stl


%.stl: %.scad
	$(OPENSCAD) $< -o $@
	$(ADMESH) $@ -b $@


# The end.
