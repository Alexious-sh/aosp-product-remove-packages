### Support PRODUCT_REMOVE_PACKAGES and PRODUCT_REMOVE_FILES for AOSP build

There is no way to exclude pakages, already included into the PRODUCT_PACKAGES, e.g. by some of the root mk files, but we can define own module, which will override every package, we want to exclude from the build, using LOCAL_OVERRIDES_PACKAGES.

### Usage
Every package, included to the **PRODUCT_REMOVE_PACKAGES** list will be overriden by this project.
Additionally, you can use **PRODUCT_REMOVE_FILES** to remove redundant files, copied by **PRODUCT_COPY_FILES**.
```
PRODUCT_REMOVE_PACKAGES := \
    Contacts \
    Calendar

PRODUCT_REMOVE_FILES := \
    $(TARGET_COPY_OUT_PRODUCT)/media/audio

# Do not forget to include this package as well
PRODUCT_PACKAGES += package_filter
```
