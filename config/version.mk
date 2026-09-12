CUSTOM_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
DIVA_BUILD_DATE := $(shell date +%d/%m/%Y)
DIVA_BASE_VERSION := 1.1.2
DIVA_VERSION := Project_Diva_$(DIVA_BASE_VERSION)_$(DIVA_BUILD_DATE)

CUSTOM_PLATFORM_VERSION := 17.0

CUSTOM_VERSION := $(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)
CUSTOM_VERSION_PROP := seventeen

# Project Diva Platform Version - Reviviendo el BP4A con elegancia
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.build.date=$(CUSTOM_BUILD_DATE) \
    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.version=$(CUSTOM_VERSION) \
    ro.diva.version=$(DIVA_VERSION) \
    ro.build.id=Project_Diva \
    ro.system.build.id=Project_Diva \
    ro.build.display.id=$(DIVA_VERSION) \
    net.pixelos.version=$(CUSTOM_VERSION_PROP)

# Updater
ifeq ($(IS_OFFICIAL),true)
    PRODUCT_PRODUCT_PROPERTIES += \
        net.pixelos.build_type=ci \
        net.pixelos.version=$(CUSTOM_VERSION_PROP)
endif
