## First, the github project "https://github.com/aoumess/RNAseqAnalysis" has to be cloned in the "ENV" directory of the current local project
## Exemple : git clone https://github.com/aoumess/RNAseqAnalysis /home/job/WORKSPACE/RESOURCES/ENVIRONMENTS/20250224

ROOT_DIR="/home/job/WORKSPACE/RESOURCES/ENVIRONMENTS/20250224"
MAIN_ENV_DIR="${ROOT_DIR}/RNAseqAnalysis"
CREATE_ENV_PREFIX="${MAIN_ENV_DIR}/CREATE"
INSTALL_ENV_PREFIX="${MAIN_ENV_DIR}/INSTALL"
ENVRECIPE="${MAIN_ENV_DIR}/env/rnaseq_analysis_env.txt"
ENVTOOL="micromamba"

## Clone the RNAseqAnalysis repo
mkdir -p "${ROOT_DIR}"
git clone https://github.com/aoumess/RNAseqAnalysis "${ROOT_DIR}/RNAseqAnalysis"


## Create first env (that will be replaced by an explicit pin)
# "${ENVTOOL}" create --prefix "${CREATE_ENV_PREFIX}" -c conda-forge -c bioconda -c nodefaults -c r --channel-priority disabled r-base r-samr rstudio-desktop hunspell-en r-amap r-bigmemory r-ashr r-circlize r-coop r-data.table r-dendextend r-dplyr r-envstats r-ggplot2 r-ggridges r-immunedeconv r-matrixstats r-msigdbr r-nmf r-openxlsx r-purrr r-randomcolor r-remotes r-rsvg r-rcolorbrewer r-vcd r-r.utils r-skmeans r-stringr r-synchronicity r-tibble r-tidyr r-writexl r-writexls r-ggpubr r-glmmTMB r-lmerTest r-pbapply r-pbmcapply r-ggsci r-ggsignif r-ggsurvfit r-survminer r-polynom r-rstatix r-TMB r-reformulas r-broom r-corrplot r-car r-carData r-abind r-pbkrtest r-quantreg r-lme4 r-numDeriv r-doBy r-MatrixModels r-Deriv r-modelr r-microbenchmark r-Rdpack r-rbibutils r-boot r-minqa r-nloptr r-ggfortify r-forcats bioconductor-arrayqualitymetrics bioconductor-annotationdbi bioconductor-biomart  bioconductor-org.hs.eg.db  bioconductor-reactome.db  bioconductor-genomeinfodbdata bioconductor-go.db bioconductor-hdo.db bioconductor-clusterprofiler bioconductor-complexheatmap bioconductor-deseq2 bioconductor-dose bioconductor-enrichplot bioconductor-enrichmentbrowser bioconductor-fgsea bioconductor-go.db bioconductor-gseabase bioconductor-gsva bioconductor-hdo.db bioconductor-ihw bioconductor-limma bioconductor-org.hs.eg.db bioconductor-pathview bioconductor-reactome.db bioconductor-reactomepa bioconductor-sva bioconductor-summarizedexperiment
## EXPORT explicit recipe (with md5)
# conda list --prefix "${CREATE_ENV_PREFIX}" --md5 --explicit > "${ENVRECIPE}"

## Install env using the explicit receipt
"${ENVTOOL}" create --prefix "${INSTALL_ENV_PREFIX}" -c conda-forge -c bioconda -c nodefaults -c r --channel-priority disabled -f "${ENVRECIPE}"

## Activate the environment
"${ENVTOOL}" activate "${INSTALL_ENV_PREFIX}"

## Install / update glmmSeq  & kmndirs packages (from github)
R --no-environ -e '.libPaths(new = "${INSTALL_ENV_PREFIX}/lib/R/library", include.site = FALSE) ; remotes::install_github("myles-lewis/glmmSeq@v0.5.5") ; remotes::install_github(repo = "r-forge/kmndirs", subdir = "pkg/kmndirs", tag = "94883aa") ; remotes::install_github("renozao/NMF", tag = "0.30.4.900", ref = "devel", force = TRUE)'

## Done ! One can use the included Rstudio and open the desired RMD (QC, then Analysis)
rstudio &
