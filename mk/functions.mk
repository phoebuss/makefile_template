# $(call stack_push,stack,value)
# Push <value> into <stack>.
# The newly added <value> can be obtained via $(firstword stack).
stack_push = $(eval $(call _stack_push,$(1),$(2)))
define _stack_push
$(1) := $(2) $$($(1))
endef

# $(call stack_pop,stack)
# Pop the last value from <stack>.
stack_pop = $(eval $(call _stack_pop,$(1)))
define _stack_pop
$(1) := $$(wordlist 2,$$(words $$($(1))),$$($(1)))
endef

# $(call include_dir,dir)
# Include the Rules.mk in <dir>.
# $(D) is set to the absolute path of <dir>.
include_dir = $(eval $(call _include_dir,$(1)))
D := $(TOP)
D_STACK := $(TOP)
define _include_dir
D := $(D)/$(1)
$$(call stack_push,D_STACK,$$(D))
_RULESMK := $$(D)/Rules.mk
$$(info Parsing $$(_RULESMK) ...)
include $$(_RULESMK)
$$(call stack_pop,D_STACK)
D :=$$(firstword $$(D_STACK))
endef

# $(call include_dirs)
# Include all directories listed in $(DIRS).
# $(DIRS) should be defined before calling this function.
include_dirs = $(eval $(call _include_dirs))
define _include_dirs
$$(foreach _SD,$$(DIRS),$$(call include_dir,$$(_SD)))
endef
