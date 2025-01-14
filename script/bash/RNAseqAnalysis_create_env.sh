PROJDIR="/home/job/WORKSPACE/PROJECTS/B24082_MOBA_01_RT045.24_nCounter"
BIGRCODE="B24082_MOBA_01"
ENVPREFIX="${PROJDIR}/ENV/rnaseq_analysis"
# ENVEXPLICIT="/home/job/WORKSPACE/PROJECTS/B24082_MOBA_01_RT045.24_nCounter/gitlab/rnaseq_analysis_env_explicit.txt"
ENVRECIPE="${ENVPREFIX}/env/rnaseq_analysis_env.txt"
ENVTOOL="micromamba"
GITPROJECT="https://github.com/aoumess/RNAseqAnalysis"
# RNAFUNCTIONSR="https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/RNA_functions.R"
# SVGPNGR="https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/svg_png.R"

## Create dir where env will be installed
mkdir -p ${ENVPREFIX}

## Create first env (that will be replaced by an explicit pin)
# ${ENVTOOL} create --prefix "${ENVPREFIX}/CREATE" -c conda-forge -c bioconda -c nodefaults --channel-priority disabled r-base rstudio-desktop r-amap r-ashr r-circlize r-coop r-data.table r-dplyr r-envstats r-ggplot2 r-ggridges r-immunedeconv r-matrixstats r-msigdbr r-openxlsx r-purrr r-randomcolor r-remotes r-rsvg r-rcolorbrewer r-r.utils r-stringr r-tibble r-tidyr r-writexl r-writexls r-ggpubr r-glmmTMB r-lmerTest r-pbapply r-pbmcapply r-ggsci r-ggsignif r-polynom r-rstatix r-TMB r-reformulas r-broom r-corrplot r-car r-carData r-abind r-pbkrtest r-quantreg r-lme4 r-numDeriv r-doBy r-MatrixModels r-Deriv r-modelr r-microbenchmark r-Rdpack r-rbibutils r-boot r-minqa r-nloptr r-ggfortify r-forcats bioconductor-arrayqualitymetrics bioconductor-annotationdbi bioconductor-clusterprofiler bioconductor-complexheatmap bioconductor-deseq2 bioconductor-dose bioconductor-enrichplot bioconductor-enrichmentbrowser bioconductor-fgsea bioconductor-go.db bioconductor-gseabase bioconductor-gsva bioconductor-hdo.db bioconductor-ihw bioconductor-limma bioconductor-org.hs.eg.db bioconductor-pathview bioconductor-reactome.db bioconductor-reactomepa bioconductor-sva bioconductor-summarizedexperiment
## EXPORT explicit recipe (with md5)
# conda list --prefix "${ENVPREFIX}/CREATE" --md5 --explicit > "${ENVPREFIX}/Env_recipe_explicit.md5.txt"

## Clone the environment recipe from github
git clone ${GITPROJECT} ${ENVPREFIX}

## Install env using the explicit receipt
${ENVTOOL} create --prefix "${ENVPREFIX}/install" -c conda-forge -c bioconda -c nodefaults --channel-priority disabled -f ${ENVRECIPE}

## Install glmmSeq package (from github)
${ENVTOOL} activate "${ENVPREFIX}/install"
R --no-environ -e '.libPaths(new = "${ENVPREFIX}/install/lib/R/library", include.site = FALSE) ; remotes::install_github("myles-lewis/glmmSeq@v0.5.5")'

##  Analysis script to use is : https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/RNA_functions.R (git-cloned in ${ENVPREFIX}/install/script/R/RNA_functions.R)
##  It also requires : https://raw.githubusercontent.com/aoumess/customscripts/76e2215359f11daca00a582c3259828a2d8a74fd/R/svg_png.R (git-cloned in ${ENVPREFIX}/install/script/R/svg_png.R)

## Done ! One can use the included Rstudio
rstudio --no-environ &