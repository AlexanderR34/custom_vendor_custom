# Include maintainer and project settings
-include vendor/custom/config/maintainer.mk

CUSTOM_BUILD_RANDOM := $(shell python3 -c 'import random; print(f"{random.randint(0, 9999):04d}")')
CUSTOM_BUILD_DATE_DAY := $(shell date -u +%Y%m%d)
CUSTOM_BUILD_DATE := $(CUSTOM_BUILD_DATE_DAY)-$(CUSTOM_BUILD_RANDOM)
DIVA_BUILD_DATE := $(shell date +%d/%m/%Y)
DIVA_BASE_VERSION ?= 1.2.1
DIVA_VERSION := Project_diva-$(DIVA_BASE_VERSION)-$(CUSTOM_BUILD_DATE)
DIVA_MAINTAINER ?= AlexMainMandy
DIVA_BUILD_TYPE ?= Official

CUSTOM_PLATFORM_VERSION := 17.0

CUSTOM_VERSION := $(CUSTOM_BUILD)-$(CUSTOM_PLATFORM_VERSION)-$(CUSTOM_BUILD_DATE)
CUSTOM_VERSION_PROP := seventeen

# Project Diva Platform Version - Reviviendo el BP4A con elegancia
PRODUCT_PRODUCT_PROPERTIES += \
    ro.custom.build.date=$(CUSTOM_BUILD_DATE) \

    ro.custom.device=$(CUSTOM_BUILD) \
    ro.custom.version=$(CUSTOM_VERSION) \
    ro.custom.maintainer=$(DIVA_MAINTAINER) \
    ro.diva.version=$(DIVA_BASE_VERSION) \
    ro.diva.maintainer=$(DIVA_MAINTAINER) \
    ro.diva.buildtype=$(DIVA_BUILD_TYPE) \
    net.pixelos.version=$(CUSTOM_VERSION_PROP) \
    net.pixelos.build_type=$(shell echo $(DIVA_BUILD_TYPE) | tr '[:upper:]' '[:lower:]')
