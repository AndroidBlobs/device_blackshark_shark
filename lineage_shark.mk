# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from shark device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_BRAND := blackshark
PRODUCT_DEVICE := shark
PRODUCT_MANUFACTURER := blackshark
PRODUCT_NAME := lineage_shark
PRODUCT_MODEL := shark

PRODUCT_GMS_CLIENTID_BASE := android-blackshark
TARGET_VENDOR := blackshark
TARGET_VENDOR_PRODUCT_NAME := shark
PRODUCT_BUILD_PROP_OVERRIDES += PRIVATE_BUILD_DESC="shark-user 10 G66X1912230CN00DQX V11.0.4.0.JOYUI release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := blackshark/SKR-A0/shark:10/G66X1912230CN00DQX/V11.0.0.0.QG66XCN:user/release-keys
