TOP := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

include $(TOP)/mk/functions.mk

DIRS := base main modules
$(call include_dirs)

all:
	@echo -n
