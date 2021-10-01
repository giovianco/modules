include modules/Makefile.inc

LOGDIR = log/sufam.$(NOW)

SUFAM_ENV = $(HOME)/share/usr/anaconda-envs/sufam-dev
SUFAM_OPTS = --format sufam --mpileup-parameters='-A -B -d 0'


sufam: $(foreach sample,$(SAMPLES),vcf/$(sample).txt)

define sufam-genotype
vcf/$1.txt : vcf/$1.vcf bam/$1.bam
	$$(call RUN, -c -s 2G -m 3G -v $$(SUFAM_ENV),"sufam --sample_name $1 $$(SUFAM_OPTS) $$(REF_FASTA) $$(^) > $$(@)")

endef
$(foreach sample,$(SAMPLES),\
		$(eval $(call sufam-genotype,$(sample))))

..DUMMY := $(shell mkdir -p version; \
	     $(SUFAM_ENV)/bin/sufam --version &> version/sufam.txt)
.DELETE_ON_ERROR:
.SECONDARY:
.PHONY: sufam
