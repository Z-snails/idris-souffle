IDRIS := idris2

TARGET = libidris_souffle-idris
TARGET_VERSION ?= 0

SHAREDLIB_INSTALLDIR = `${IDRIS} --libdir`/ncurses-idris-${TARGET_VERSION}/lib

CXX_VERSION = $(shell $(CXX) --version)

ifeq ($(findstring clang,$(CC_VERSION)),clang)
 DYLIB_WORKAROUND = cp "${SHAREDLIB_INSTALLDIR}/${TARGET}" "${SHAREDLIB_INSTALLDIR}/${TARGET}.dylib"
else
 DYLIB_WORKAROUND = cp "${SHAREDLIB_INSTALLDIR}/${TARGET}" "${SHAREDLIB_INSTALLDIR}/${TARGET}.so"
 CFLAGS += -fPIC
 LDFLAGS += -fuse-ld=gold
endif

SRCS = $(wildcard *.cpp)
OBJS = $(SRCS:.cpp=.o)
DEPS = $(OBJS:.o=.d)

all: $(TARGET)$(SHLIB_SUFFIX)

$(TARGET)$(SHLIB_SUFFIX): $(OBJS)
	$(CC) -shared -o $@ $^


-include $(DEPS)

%.d: %.cpp
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

.PHONY: clean

clean:
	rm -f $(OBJS) $(TARGET)$(SHLIB_SUFFIX)

cleandep: clean
	rm -f $(DEPS)

.PHONY: install

install:
	idris2 --install ncurses-idris.ipkg
	@if ! [ -d $(SHAREDLIB_INSTALLDIR) ]; then mkdir -p $(SHAREDLIB_INSTALLDIR); fi
	install $(TARGET)$(SHLIB_SUFFIX) $(wildcard *.h) $(SHAREDLIB_INSTALLDIR)
	$(DYLIB_WORKAROUND)