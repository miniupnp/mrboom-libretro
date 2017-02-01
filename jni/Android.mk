LOCAL_PATH := $(call my-dir)
GIT_VERSION := " $(shell git rev-parse --short HEAD)"

include $(CLEAR_VARS)

LOCAL_CFLAGS += -DGIT_VERSION=\"$(GIT_VERSION)\"

ifeq ($(TARGET_ARCH),arm)
LOCAL_CFLAGS += -DANDROID_ARM
LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
LOCAL_CFLAGS +=  -DANDROID_X86
endif

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS += -DANDROID_MIPS -D__mips__ -D__MIPSEL__
endif

CORE_DIR := ..

LOCAL_MODULE    := retro

include ../Makefile.common

LOCAL_SRC_FILES  = $(SOURCES_C)

LOCAL_CFLAGS += -std=c99 -DINLINE=inline -D__LIBRETRO__ -DFRONTEND_SUPPORTS_RGB565 $(INCFLAGS) -O1
LOCAL_C_INCLUDES = $(LOCAL_PATH)/$(CORE_DIR) \
						 $(INCFLAGS)

include $(BUILD_SHARED_LIBRARY)
