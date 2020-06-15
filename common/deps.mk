
../common/utils.scad : | ../common/copies.scad

../common/threads.scad :
	$(WGET) -O $(TOPDIR)/common/threads.scad https://dkprojects.net/openscad-threads/threads.scad
