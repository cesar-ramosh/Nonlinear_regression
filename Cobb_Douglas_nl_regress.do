* Estimating Cobb Douglas Production Function in Stata

* We use the following function: ln(Q(K,L)) = \beta_0 + \beta_1 ln(L) + \beta_2 ln(K) + \varepsilon

***use "http://www.stata-press.com/data/r10/production.dta"
clear all
cls

* Change the current work directory
cd "D:\Paulo Ramos\Nueva carpeta (3)\Unidad de Análisis y Estudios Fiscales UAEF\Investigador Econométrico 9\Optimal Investment\Nonlinear Regression FP Cobb Douglas"

use dataset_cb_nl.dta

*nl (lnoutput = {b0=1} + {b1=0.5}*ln(capital) + {b2=0.5}*ln(labor))

*nl (lnoutput = {b0=1} + {b1=0.3}*ln(capital) + {b2=0.7}*ln(labor))


gen output = exp(lnoutput)
nl (output = {b0=1} * (capital^{b1=0.3}) * (labor^{b2=0.7}))