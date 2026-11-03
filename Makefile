ARCHS := arm64 arm64e
TARGET := iphone:clang:16.5:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := XsGpS

SOURCE_DIR := Source
SOURCE_M_FILES_RAW := $(sort $(wildcard $(SOURCE_DIR)/*.m))
ROOT_M_FILES_RAW := $(sort $(wildcard *.m))
XS_GPS_ALL_M_FILES := $(if $(ROOT_M_FILES_RAW),$(ROOT_M_FILES_RAW),$(SOURCE_M_FILES_RAW))

# v60 build fix:
ifneq ($(filter XsGpS.m $(SOURCE_DIR)/XsGpS.m,$(XS_GPS_ALL_M_FILES)),)
XsGpS_FILES := $(filter-out LocationSpoofer.m $(SOURCE_DIR)/LocationSpoofer.m,$(XS_GPS_ALL_M_FILES))
else
XsGpS_FILES := $(XS_GPS_ALL_M_FILES)
endif

XsGpS_CFLAGS := -fobjc-arc -Wall -Wextra -Wno-error -Wno-nullability-completeness -Wno-unused-parameter -Wno-deprecated-declarations -I$(SOURCE_DIR) -I.
XsGpS_FRAMEWORKS := Foundation UIKit CoreLocation MapKit Photos CoreBluetooth AVFoundation CoreMedia Security WebKit SystemConfiguration UserNotifications

include $(THEOS)/makefiles/tweak.mk
