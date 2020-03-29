SHELL = /bin/bash

prefix ?= /usr/local
bindir ?= $(prefix)/bin
libdir ?= $(prefix)/lib

docsetutil: Developer/usr/bin/docsetutil

.PHONY: install
install: docsetutil
	@install -d "$(bindir)" "$(libdir)/docsetutil"
	@ditto Developer "$(libdir)/docsetutil/Developer"
	@ditto Frameworks "$(libdir)/docsetutil/Frameworks"
	@ditto SharedFrameworks "$(libdir)/docsetutil/SharedFrameworks"
	@ln -s "$(libdir)/docsetutil/Developer/usr/bin/docsetutil" "$(bindir)/docsetutil"

.PHONY: uninstall
uninstall:
	@rm -rf "$(bindir)/docsetutil"
	@rm -rf "$(libdir)/docsetutil"
