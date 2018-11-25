include modules/Makefile.inc

LOGDIR ?= log/cnvkit_qc.$(NOW)
PHONY += cnvkit cnvkit/qc

CNVKIT_NORMAL ?= $(wildcard $(foreach sample,$(NORMAL_SAMPLES),cnvkit/cnr/$(sample).cnr))
CNVKIT_TUMOR ?= $(wildcard $(foreach sample,$(TUMOR_SAMPLES),cnvkit/cnr/$(sample).cnr))

cnvkit : cnvkit/qc/ontarget.tsv cnvkit/qc/offtarget.tsv

cnvkit/qc/ontarget.tsv : $(wildcard cnvkit/cnr/$(SAMPLES).cnr)
	$(call RUN,-c -v ~/share/usr/anaconda-envs/ascat -s 8G -m 16G,"$(RSCRIPT) modules/copy_number/cnvkitqc.R --normal_files '$(CNVKIT_NORMAL)' --tumor_files '$(CNVKIT_TUMOR)' --out_file cnvkit/qc/ontarget.tsv --option 1")
	
cnvkit/qc/offtarget.tsv : $(wildcard cnvkit/cnr/$(SAMPLES).cnr)
	$(call RUN,-c -v ~/share/usr/anaconda-envs/ascat -s 8G -m 16G,"$(RSCRIPT) modules/copy_number/cnvkitqc.R --normal_files '$(CNVKIT_NORMAL)' --tumor_files '$(CNVKIT_TUMOR)' --out_file cnvkit/qc/offtarget.tsv --option 0")
				
.PHONY: $(PHONY)