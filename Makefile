info:
	@echo "builddeb [NO_SIGN=1]  - build deb package for Ubuntu LTS [NO_SIGN disables signing]"
	@echo "clean                 - clean build directory DEBUILD"

VERSION = 0.1
SRC_DIR = yubikey_luks_1fa.orig

DIST_FILES =					\
	debian/rules				\
	debian/changelog			\
	debian/compat				\
	debian/control				\
	debian/copyright			\
	debian/yubikey-luks-1fa.postinst	\
	hook					\
	key-script				\
	README.md				\
	${NULL}

dist:
	tar czvf yubikey-luks-1fa_${VERSION}.tar.gz ${DIST_FILES}

debianize:
	rm -fr DEBUILD
	mkdir -p DEBUILD/${SRC_DIR}
	cp -r * DEBUILD/${SRC_DIR} || true
	(cd DEBUILD; tar -zcf yubikey-luks-1fa_${VERSION}.orig.tar.gz --exclude=${SRC_DIR}/debian  ${SRC_DIR})

builddeb:
	make debianize
ifndef NO_SIGN
	(cd DEBUILD/${SRC_DIR}; debuild)
else
	(cd DEBUILD/${SRC_DIR}; debuild -uc -us)
endif

clean:
	rm -fr DEBUILD
