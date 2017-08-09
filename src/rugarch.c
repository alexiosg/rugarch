// RegisteringDynamic Symbols

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include "distributions.h"
#include "filters.h"
#include "fracdiff.h"
#include "gig.h"
#include "nig.h"
#include "rugarch.h"

/* .Fortran calls */
extern void F77_NAME(fdsim)(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);

static const R_CMethodDef CEntries[] = {
    {"aparchfilterC",    (DL_FUNC) &aparchfilterC,    18},
    {"aparchsimC",       (DL_FUNC) &aparchsimC,        9},
    {"arfimafitC",       (DL_FUNC) &arfimafitC,       14},
    {"arfimaxfilterC",   (DL_FUNC) &arfimaxfilterC,   12},
    {"armaxsim",         (DL_FUNC) &armaxsim,          8},
    {"c_dged",           (DL_FUNC) &c_dged,            7},
    {"c_dgh",            (DL_FUNC) &c_dgh,             9},
    {"c_dghst",          (DL_FUNC) &c_dghst,           8},
    {"c_dghyp",          (DL_FUNC) &c_dghyp,           9},
    {"c_djsu",           (DL_FUNC) &c_djsu,            8},
    {"c_dsged",          (DL_FUNC) &c_dsged,           8},
    {"c_dsnig",          (DL_FUNC) &c_dsnig,           8},
    {"c_dsnorm",         (DL_FUNC) &c_dsnorm,          7},
    {"c_dsstd",          (DL_FUNC) &c_dsstd,           8},
    {"c_dstd",           (DL_FUNC) &c_dstd,            7},
    {"c_pged",           (DL_FUNC) &c_pged,            6},
    {"c_pjsu",           (DL_FUNC) &c_pjsu,            7},
    {"c_psged",          (DL_FUNC) &c_psged,           7},
    {"c_psnorm",         (DL_FUNC) &c_psnorm,          6},
    {"c_psstd",          (DL_FUNC) &c_psstd,           7},
    {"c_pstd",           (DL_FUNC) &c_pstd,            6},
    {"c_qged",           (DL_FUNC) &c_qged,            6},
    {"c_qjsu",           (DL_FUNC) &c_qjsu,            7},
    {"c_qsged",          (DL_FUNC) &c_qsged,           7},
    {"c_qsnorm",         (DL_FUNC) &c_qsnorm,          6},
    {"c_qsstd",          (DL_FUNC) &c_qsstd,           7},
    {"c_qstd",           (DL_FUNC) &c_qstd,            6},
    {"c_rged",           (DL_FUNC) &c_rged,            5},
    {"c_rghst",          (DL_FUNC) &c_rghst,           6},
    {"c_rghyp",          (DL_FUNC) &c_rghyp,           7},
    {"c_rjsu",           (DL_FUNC) &c_rjsu,            6},
    {"c_rsged",          (DL_FUNC) &c_rsged,           6},
    {"c_rsnig",          (DL_FUNC) &c_rsnig,           6},
    {"c_rsnorm",         (DL_FUNC) &c_rsnorm,          5},
    {"c_rsstd",          (DL_FUNC) &c_rsstd,           6},
    {"c_rstd",           (DL_FUNC) &c_rstd,            5},
    {"csgarchfilterC",   (DL_FUNC) &csgarchfilterC,   19},
    {"csgarchsimC",      (DL_FUNC) &csgarchsimC,      11},
    {"egarchfilterC",    (DL_FUNC) &egarchfilterC,    19},
    {"egarchsimC",       (DL_FUNC) &egarchsimC,       10},
    {"fgarchfilterC",    (DL_FUNC) &fgarchfilterC,    19},
    {"fgarchsimC",       (DL_FUNC) &fgarchsimC,       10},
    {"fracdiff",         (DL_FUNC) &fracdiff,          5},
    {"gjrgarchfilterC",  (DL_FUNC) &gjrgarchfilterC,  19},
    {"gjrgarchsimC",     (DL_FUNC) &gjrgarchsimC,     11},
    {"mcsgarchfilterC",  (DL_FUNC) &mcsgarchfilterC,  15},
    {"mcsgarchsimC",     (DL_FUNC) &mcsgarchsimC,     10},
    {"qNIG",             (DL_FUNC) &qNIG,              7},
    {"realgarchfilterC", (DL_FUNC) &realgarchfilterC, 21},
    {"realgarchsimC",    (DL_FUNC) &realgarchsimC,    12},
    {"sgarchfilterC",    (DL_FUNC) &sgarchfilterC,    18},
    {"sgarchsimC",       (DL_FUNC) &sgarchsimC,       10},
    {NULL, NULL, 0}
};

static const R_FortranMethodDef FortranEntries[] = {
    {"fdsim", (DL_FUNC) &F77_NAME(fdsim), 13},
    {NULL, NULL, 0}
};

void R_init_rugarch(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, FortranEntries, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
