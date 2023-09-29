import excel "C:\Users\dapaf\OneDrive\Desktop\Copia di 2021 ECOLET 1974-1982_con indicatori74-79_last.xlsx", sheet("PANELDATA") firstrow

gen id=NOME
order id

encode NOME, generate (ID)
xtset ID ANNO
sort ID ANNO

*To observe heterogeneity of ROE across the years
bysort ANNO: egen mean_ROE_ANNO=mean(ROE)
bysort ANNO: egen SD_ROE_ANNO=sd(ROE)
table mean_ROE_ANNO ANNO

twoway scatter mean_ROE_ANNO ANNO, msymbol(circle_hollow) color(gs14) || ///
connected mean_ROE ANNO, msymbol(diamond) sort ///
ylabel(0.2(0)0.7, angle(0) labsize(2) format(%7.0fc)) ///
xlabel(1974(1)1977, angle(45) labsize(2) grid) ///
title(mean_ROEeach year  xtitle(Year, size(2.5)) ///
legend(label(1 "ROE per ANNO") label(2 "Mean ROE per ANNO")))
hist ROE, xlabel(-4(0.3)2)
table mean_ROE NETWORKP2 ANNO
ttest mean_ROE, by(NETWORKP2) unequal
tabulate mean_ROE ANNO, chi2
tabulate NETWORKP2 ANNO, chi2
tabulate SD_ROE_ANNO ANNO, chi2
tabulate mean_ROE NETWORKP2, chi2
bysort ANNO: ci mean ROE

bysort ANNO: tab NETWORKP2



pwcorr NETWORKP2 EV Nazionisti FINANCIALSECTOR Dividendi P2 NETWORK time_to_event2
table ANNO

ssc install did_imputation, replace

help did_imputation

gen time_to_event = ANNO-Event
gen time_to_event2 =ANNO-Event2

table time_to_event
table time_to_event2
table Event
table Event2


help did_imputation
ssc install event_plot



******* POSSIBILE CORRETTO
did_imputation ROE ID ANNO time_to_event2, fe(ID ANNO) horizons(0/2) pretrend(2) autosample minn(0)
outreg2 using "tab3fe.xls",  excel bracket bdec(3) sdec(3)  replace
coefplot, order(pre3 pre2 pre1 tau0 tau1 tau2 tau3) keep(pre1 pre2 pre3 tau3 tau2 tau1 tau0) yline(0) xline(9.5) vertical msymbol(D) mfcolor(white) ciopts(lwidth(*3) lcolor(*.6)) mlabel format(%9.3f) mlabposition(12) mlabgap(*2) title(ROE EVENT STUDY)



