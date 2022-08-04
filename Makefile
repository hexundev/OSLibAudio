#----------------------------------------------------------------------------
#       MAKEFILE
#
#	Controlling makefile for File Assistant
#
#	Created:	1st August 2005
#
#	Copyright (C) 1995-2005 T Swann
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
#	Target to make
#	--------------

#PATH 		:= /c/devkitPro/devkitPSP/bin:$(PATH)

STATICLIB = liboslModAudio112.a
TARGET := OSLibModAudio112
PSP_FW_VERSION=371

#----------------------------------------------------------------------------
#	Project folders
#	---------------

#<-- STAS: pack all the necessary MikMod stuff directly into libosl.a
#          in order to avoid conflict with the newest libmikmod releases.
SOURCE_DIR := source
MM_DIR := $(SOURCE_DIR)mikmod
INCLUDE_DIR := $(MM_DIR)
#<-- STAS END -->

#----------------------------------------------------------------------------
#	Source to make
#	--------------

LIBOBJS :=					$(SOURCE_DIR)/audio.o \
							$(SOURCE_DIR)/bgm.o \
							$(SOURCE_DIR)/vfsFile.o \
							$(SOURCE_DIR)/VirtualFile.o \

OBJS :=						$(LIBOBJS)

#----------------------------------------------------------------------------
#	Additional includes
#	-------------------

INCDIR   :=					$(INCDIR) \
							$(INCLUDE_DIR)

#----------------------------------------------------------------------------
#	Addditional libraries
#	---------------------
SDK_LIBS :=					-lpspsdk \
							-lpspctrl -lpsphprm \
							-lpspumd \
							-lpsprtc \
							-lpspgu -lpspgum \
							-lpspaudiolib \
							-lpspaudio \
							-lpsppower \
							-lpspusb -lpspusbstor \


EXTERN_LIBS :=				-lz

LIBS :=						$(EXTERN_LIBS) \
							$(SDK_LIBS) \
							-lm

#----------------------------------------------------------------------------
#	Preprocesser defines
#	--------------------

DEFINES :=					-DPSP

#----------------------------------------------------------------------------
#	Compiler settings
#	-----------------

CFLAGS :=					$(DEFINES) -O2 -G0 -ggdb -Wall -DHAVE_AV_CONFIG_H -fno-strict-aliasing -fverbose-asm 
#CFLAGS :=					$(DEFINES) -O2 -G0 -g -frename-registers -ffast-math -fomit-frame-pointer -Wall -DHAVE_AV_CONFIG_H -fno-strict-aliasing
CXXFLAGS :=					$(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS :=					$(CFLAGS)

LIBDIR :=

LDFLAGS :=

#----------------------------------------------------------------------------
#	PBP parameters
#	--------------

#EXTRA_TARGETS :=			EBOOT.PBP
#PSP_EBOOT_ICON :=			../ICON0.PNG
#PSP_EBOOT_PIC1 :=			../PIC1.PNG
#PSP_EBOOT_TITLE :=			Oldschool Library for PSP

#----------------------------------------------------------------------------
#	Default build settings
#	----------------------

#test:
#	echo $(OBJS)

PSPSDK :=					$(shell psp-config --pspsdk-path)

include						$(PSPSDK)/lib/build.mak

#----------------------------------------------------------------------------
#	Copy to PSP
#	-----------

lib: $(STATICLIB)

$(STATICLIB): $(LIBOBJS)
	$(AR) rcs $@ $(LIBOBJS)
	$(RANLIB) $@
