include modules/Makefile.inc

LOGDIR = log/sufam.$(NOW)

SUFAM_ENV = $(HOME)/share/usr/anaconda-envs/sufam-dev
SUFAM_OPTS = --format vcf --mpileup-parameters='-A -q 15 -Q 15 -d 15000'


sufam: $(foreach sample,$(SAMPLES),vcf/$(ssample).sufam.txt)

define sufam-genotype
vcf/$1.sufam.vcf : sufam/$1.set.vcf $$(foreach sample,$$(set.$1),bam/$$(sample).bam)
	$$(call RUN,-v $$(SUFAM_ENV) -s 2G -m 3G,"sufam --sample_name $$(set.$1) $$(SUFAM_OPTS) $$(REF_FASTA) $$^ > $$@")

endef
$(foreach sample,$(SAMPLES),\
		$(eval $(call sufam-genotype,$(sample))))

..DUMMY := $(shell mkdir -p version; \
	     $(SUFAM_ENV)/bin/sufam --version &> version/sufam.txt)
.DELETE_ON_ERROR:
.SECONDARY:
.PHONY: sufam
