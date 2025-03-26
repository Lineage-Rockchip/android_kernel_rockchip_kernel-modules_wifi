#
#SeekWave Platform Drivers Makefile
#
#
PWD :=$(shell pwd)
CURFOLDER ?=$(pwd)

ccflags-y :=-I$(src)/skwutil
ccflags-y +=-I$(src)/usb
ccflags-y +=-I$(src)/sdio

#ifdef CONFIG_SEEKWAVE_BSP_DRIVERS
#obj-$(CONFIG_SKW_USB)               += usb/
#obj-$(CONFIG_SKW_PCIE)               += pcie/
#obj-$(CONFIG_SKW_SDIOHAL)           += sdio/
#obj-$(CONFIG_SEEKWAVE_BSP_DRIVERS)  += skwutil/
#endif

ifeq ($(CONFIG_SKW_BT),m)
        ccflags-y += -DCONFIG_BT_SEEKWAVE
endif


ifneq ($(skw_extra_flags),)
        ccflags-y += $(skw_extra_flags) -DSKW_EXT_INC
endif

ifeq ($(CONFIG_SKW_NO_CONFIG),y)
        ccflags-y += -DCONFIG_SKW_NO_CONFIG
endif
#ccflags-y += -DCONFIG_SV6160_LITE_FPGA

obj-$(CONFIG_SKW_SDIOHAL) += skw_sdio_lite.o
skw_sdio_lite-y := ./sdio/skw_sdio_main.o
skw_sdio_lite-y += ./sdio/skw_sdio_rx.o
skw_sdio_lite-y += ./sdio/skw_sdio_debugfs.o
skw_sdio_lite-y += ./sdio/skw_sdio_log.o
skw_sdio_lite-y += ./skwutil/skw_user_com.o
skw_sdio_lite-y += ./skwutil/skw_log_to_file.o
skw_sdio_lite-y += ./skwutil/skw_boot.o

obj-$(CONFIG_SKW_USB) += skw_usb_lite.o
skw_usb_lite-y := ./usb/skw_usb_io.o
skw_usb_lite-y += ./usb/skw_usb_debugfs.o
skw_usb_lite-y += ./usb/skw_usb_log.o
#skw_usb_lite-y += ./usb/skw_test.o
skw_usb_lite-y += ./skwutil/skw_user_com.o
skw_usb_lite-y += ./skwutil/skw_log_to_file.o
skw_usb_lite-y += ./skwutil/skw_boot.o

clean:
	@rm -rf *.o *.ko *.mod.c *.order *.a *.builtin .*.cmd .*.d

