include modules/Makefile.inc

LOGDIR ?= log/marianas_access.$(NOW)
PHONY += bam marianas cnvaccess

MSK_ACCESS_WORKFLOW += clip_umi

msk_access_workflow : $(MSK_ACCESS_WORKFLOW)

include modules/test/bam_tools/clipumi.mk

.DELETE_ON_ERROR:
.SECONDARY:
.PHONY: $(PHONY)