* Nonlinear estimation of CES  production function

/*
video: https://www.youtube.com/watch?v=grP9NpCt2NQ
- A set of starting values or inicial guesses for all the parameters must be supplied
in addtion to data
- Or at based on theorical considerations or by plotting the sample data.
- Using a logarithmic version of CES production function:

ln(Q(K,L)) = \beta_0 - (1/\rho)*ln[\alpha*K^(-\rho) + (1-\alpha)*L^(-\rho)] + \varepsilon
*/

**use "http://www.stata-press.com/data/r10/production.dta"
clear all
cls

* Change the current work directory
cd "D:\Paulo Ramos\Nueva carpeta (3)\Unidad de Análisis y Estudios Fiscales UAEF\Investigador Econométrico 9\Optimal Investment\Nonlinear Regression FP Cobb Douglas"

use dataset_cb_nl.dta

nl ( lnoutput = {b0} - 1/{rho=1}*ln( {delta=0.5}*capital^(-1*{rho}) + (1-{delta})*labor^(-1*{rho}) ) )

predictnl double lnoutputyhat = predict()

nlcom(1/(1+ _b[/rho]))

nlcom(1/(1+ _b[/rho])), post

** No have a Cobbb Douglas Prod. Function
testnl _b[_nl_1] = 1
** No have a Leontief Prod. Function
testnl _b[_nl_1] = 0

/*
- Braces tell "nl", that parameters are in them
- parameters set to zero by default (i.e. if the initial values are not supplied) e.g. {b0} above.
- However, this by default value may not work in some nonlinear functions
- Initial value should be give once e.g. rho and delta
- No need to mention initial value if set equal to zero
- nlcom(1/(1+ _b[\rho]))
	° Determine (\sigma) and its statistical significance
- nlcom(1/(1+ _b[\rho])), post
- testnl _b[_nl_1] = 1
	° (\sigma) is significantly different from 1 - Not Cobb-Douglas P.F.
- testnl _b[_nl_1] = 0
	° (\sigma) is significantly different from 0 - Not Leontief P.F.
*/

* Working in levels

gen output = exp(lnoutputyhat)

nl ( output = {b0=1} * ( {delta=0.5}*capital^(-1*{rho}) + (1-{delta})*labor^(-1*{rho}) )^(- 1/{rho=0.7}) )

predictnl double outputyhat = predict()

