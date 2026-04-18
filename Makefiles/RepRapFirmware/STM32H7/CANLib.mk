#---RRF Libraries----
CANLIB_SRC_BASE = $(CANLIB_DIR)/src
CANLIB_SRC_DIRS =

#  Find the c and cpp source files
CANLIB_SRC = $(CANLIB_SRC_BASE) $(addprefix $(CANLIB_SRC_BASE)/, $(CANLIB_SRC_DIRS))
CANLIB_OBJ_SRC_C      += $(foreach src, $(CANLIB_SRC), $(wildcard $(src)/*.c) ) 
CANLIB_OBJ_SRC_CXX   += $(foreach src, $(CANLIB_SRC), $(wildcard $(src)/*.cpp) )
#CANLIB_OBJ_SRC_CXX   += $(CANLIB_SRC_BASE)/RRF3Common.cpp
CANLIB_INCLUDES = -I$(CANLIB_DIR)/src

CANLIB_OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(CANLIB_OBJ_SRC_C)) $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(CANLIB_OBJ_SRC_CXX))
#end RRF Libraries

