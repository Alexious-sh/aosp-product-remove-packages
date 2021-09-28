LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

define relative-path
$(shell python -c 'import os.path, sys; print os.path.relpath(sys.argv[1],sys.argv[2])' $(1) $(2))
endef

LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)
LOCAL_MODULE := package_filter
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := packages-excluded.txt
LOCAL_INTERMEDIATE_DIR := $(call intermediates-dir-for,$(LOCAL_MODULE_CLASS),$(LOCAL_MODULE))

LOCAL_OVERRIDES_PACKAGES := $(PRODUCT_REMOVE_PACKAGES)
# By default, modules with ETC class can't use LOCAL_OVERRIDES_PACKAGES
# Compare build/core/app_prebuilt_internal.mk and build/core/misc_prebuilt_internal.mk
PACKAGES.$(LOCAL_MODULE).OVERRIDES := $(strip $(LOCAL_OVERRIDES_PACKAGES))

$(shell echo $(LOCAL_OVERRIDES_PACKAGES) > $(LOCAL_INTERMEDIATE_DIR)/$(LOCAL_MODULE_STEM).in)

LOCAL_PREBUILT_MODULE_FILE := $(LOCAL_INTERMEDIATE_DIR)/$(LOCAL_MODULE_STEM).in

ifneq ($(PRODUCT_REMOVE_FILES),)
LOCAL_POST_INSTALL_CMD := rm -rf $(PRODUCT_REMOVE_FILES)
endif

include $(BUILD_PREBUILT)
