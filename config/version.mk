CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

CUSTOM_PLATFORM_VERSION := 17.0
DIVA_VERSION := 1.1.2

CUSTOM_VERSION := $(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)
CUSTOM_VERSION_PROP := seventeen

# Project Diva Platform Version - Reviviendo el BP4A con elegancia
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.build.date=$(CUSTOM_BUILD_DATE) \
    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.version=Project Diva $(DIVA_VERSION) \
    ro.diva.version=Project Diva $(DIVA_VERSION) \
    ro.build.id=Project_Diva \
    ro.system.build.id=Project_Diva \
    ro.build.display.id=Project Diva $(DIVA_VERSION) \
    net.pixelos.version=$(CUSTOM_VERSION_PROP)

# Updater
ifeq ($(IS_OFFICIAL),true)
    PRODUCT_PRODUCT_PROPERTIES += \
        net.pixelos.build_type=ci \
        net.pixelos.version=$(CUSTOM_VERSION_PROP)
endif
