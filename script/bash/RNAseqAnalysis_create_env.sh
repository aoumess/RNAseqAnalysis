## First, the github project "https://github.com/aoumess/RNAseqAnalysis" has to be cloned in the "ENV" directory of the current local project
## Exemple : git clone https://github.com/aoumess/RNAseqAnalysis /home/job/WORKSPACE/PROJECTS/B25007_ELEL_01_RT156.24_TRICS_RNAseq.FFPE

PROJDIR="/home/job/WORKSPACE/PROJECTS/B24082_MOBA_01_RT045.24_nCounter"
BIGRCODE="B24082_MOBA_01"
ENVPREFIX="${PROJDIR}/ENV/rnaseq_analysis"
# ENVEXPLICIT="/home/job/WORKSPACE/PROJECTS/B24082_MOBA_01_RT045.24_nCounter/gitlab/rnaseq_analysis_env_explicit.txt"
ENVRECIPE="${ENVPREFIX}/env/rnaseq_analysis_env.txt"
ENVTOOL="micromamba"
# GITPROJECT="https://github.com/aoumess/RNAseqAnalysis"
# RNAFUNCTIONSR="https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/RNA_functions.R"
# SVGPNGR="https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/svg_png.R"

## Create dir where env will be installed
# mkdir -p ${ENVPREFIX}

## Create first env (that will be replaced by an explicit pin)
# ${ENVTOOL} create --prefix "${ENVPREFIX}/CREATE" -c conda-forge -c bioconda -c nodefaults -c r --channel-priority disabled r-base rstudio-desktop hunspell-en r-amap r-bigmemory r-ashr r-circlize r-coop r-data.table r-dendextend r-dplyr r-envstats r-ggplot2 r-ggridges r-immunedeconv r-matrixstats r-msigdbr r-nmf r-openxlsx r-purrr r-randomcolor r-remotes r-rsvg r-rcolorbrewer r-vcd r-r.utils r-skmeans r-stringr r-synchronicity r-tibble r-tidyr r-writexl r-writexls r-ggpubr r-glmmTMB r-lmerTest r-pbapply r-pbmcapply r-ggsci r-ggsignif r-ggsurvfit r-survminer r-polynom r-rstatix r-TMB r-reformulas r-broom r-corrplot r-car r-carData r-abind r-pbkrtest r-quantreg r-lme4 r-numDeriv r-doBy r-MatrixModels r-Deriv r-modelr r-microbenchmark r-Rdpack r-rbibutils r-boot r-minqa r-nloptr r-ggfortify r-forcats bioconductor-arrayqualitymetrics bioconductor-annotationdbi bioconductor-biomart  bioconductor-org.hs.eg.db  bioconductor-reactome.db  bioconductor-genomeinfodbdata bioconductor-go.db bioconductor-hdo.db bioconductor-clusterprofiler bioconductor-complexheatmap bioconductor-deseq2 bioconductor-dose bioconductor-enrichplot bioconductor-enrichmentbrowser bioconductor-fgsea bioconductor-go.db bioconductor-gseabase bioconductor-gsva bioconductor-hdo.db bioconductor-ihw bioconductor-limma bioconductor-org.hs.eg.db bioconductor-pathview bioconductor-reactome.db bioconductor-reactomepa bioconductor-sva bioconductor-summarizedexperiment
## EXPORT explicit recipe (with md5)
# conda list --prefix "${ENVPREFIX}/CREATE" --md5 --explicit > "${ENVPREFIX}/Env_recipe_explicit.md5.txt"

## Clone the environment recipe from github
# git clone ${GITPROJECT} ${ENVPREFIX}

## Install env using the explicit receipt
${ENVTOOL} create --prefix "${ENVPREFIX}/install" -c conda-forge -c bioconda -c nodefaults -c r --channel-priority disabled -f ${ENVRECIPE}

## Install glmmSeq package (from github)
R --no-environ -e '.libPaths(new = "${ENVPREFIX}/install/lib/R/library", include.site = FALSE) ; remotes::install_github("myles-lewis/glmmSeq@v0.5.5") ; remotes::install_github("renozao/pkgmaker") ; remotes::install_github("renozao/NMF@devel") ; remotes::install_github(repo = "r-forge/kmndirs", subdir = "pkg/kmndirs")

## Done ! One can use the included Rstudio and open the desired RMD (QC, then Analysis)
rstudio &