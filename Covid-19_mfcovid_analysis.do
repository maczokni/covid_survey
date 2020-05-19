cd "C:\Users\Krisztián\Desktop\LSE Postdoc\Covid-19\Data\Wave1"

use Covid-19_Police_Study_W1_weights.dta, replace

recode bound_1 (1=5 "Never") (2=4 "Rarely") (3=3 "Sometimes") (4=2 "Often") ///
(5=1 "Very often"), gen(bound1)
recode bound_2 (1=5 "Never") (2=4 "Rarely") (3=3 "Sometimes") (4=2 "Often") ///
(5=1 "Very often"), gen(bound2)
recode bound_3 (1=5 "Never") (2=4 "Rarely") (3=3 "Sometimes") (4=2 "Often") ///
(5=1 "Very often"), gen(bound3)

sum covidpriv_*
recode covidpriv_1 (1=5 "Strongly disagree") (2=4 "Disagree") ///
(3=3 "Neither agree, nor disagree") (4=2 "Agree") ///
 (25=1 "Strongly agree"), gen(covpriv1)
recode covidpriv_2 (1=5 "Strongly disagree") (2=4 "Disagree") ///
(3=3 "Neither agree, nor disagree") (4=2 "Agree") ///
 (25=1 "Strongly agree"), gen(covpriv2)
recode covidpriv_3 (1=5 "Strongly disagree") (2=4 "Disagree") ///
(3=3 "Neither agree, nor disagree") (4=2 "Agree") ///
 (25=1 "Strongly agree"), gen(covpriv3)
 
tab covpriv1
tab covpriv2
tab covpriv3

sum covpriv*

sem (Covpriv -> covpriv*), stand

tab mfcovid_1
tab mfcovid_2
tab mfcovid_3
tab mfcovid_4
tab mfcovid_5
tab mfcovid_6
tab mfcovid_7
tab mfcovid_8
tab mfcovid_9

sum mfcovid_*

pwcorr mfcovid_*, sig star(.05)

factor mfcovid_*

*McDonald's Omega 
matrix fl=e(L)
mat li fl
mata: st_matrix("fls", colsum(st_matrix("fl")))
mat li fls
matrix u=e(Psi)
mat li u
mata: st_matrix("us", rowsum(st_matrix("u")))
mat li us
scalar fls = fls[1,1]
scalar us = us[1,1]
matrix o=(fls^2)/(us+(fls^2))
mat li o

alpha mfcovid_*

sem (Mfcovid -> mfcovid_*), stand

estat gof, stat(all)

estat mind

*Use force
*Use facial recognition
*Track people's movement (phones)
*Use drones
factor mfcovid_2 mfcovid_3 mfcovid_5 mfcovid_7

*McDonald's Omega 
matrix fl=e(L)
mat li fl
mata: st_matrix("fls", colsum(st_matrix("fl")))
mat li fls
matrix u=e(Psi)
mat li u
mata: st_matrix("us", rowsum(st_matrix("u")))
mat li us
scalar fls = fls[1,1]
scalar us = us[1,1]
matrix o=(fls^2)/(us+(fls^2))
mat li o

alpha mfcovid_2 mfcovid_3 mfcovid_5 mfcovid_7

sem (Mfcovid -> mfcovid_2 mfcovid_3 mfcovid_5 mfcovid_7), stand

estat gof, stat(all)

sem (Mftrack -> mfcovid_3 mfcovid_5 mfcovid_7) ///
(Mfenforce -> mfcovid_1 mfcovid_2 mfcovid_4) ///
(Covpriv -> covpriv1-covpriv3), stand

estat gof, stat(all)

rename mfcovid_3 mftrack1
rename mfcovid_5 mftrack2
rename mfcovid_7 mftrack3
pwcorr mftrack*

rename mfcovid_1 mfenforce1
rename mfcovid_2 mfenforce2
rename mfcovid_4 mfenforce3
pwcorr mfenforce*

rename mfcovid_8 mfexpress

pwcorr mfenforce* mftrack* mfexpress

recode gender (1=1 "Male") (2 3 = 0 "Other"), gen(male)
recode gender (2=1 "Female") (1 3 = 0 "Other"), gen(female)
recode gender (3=1 "Non-bianry") (1 2 = 0 "Other"), gen(nonbin)

recode age (1=1 "16-24") (2 3 4 = 0 "Other"), gen(age1)
recode age (2=1 "16-24") (1 3 4 = 0 "Other"), gen(age2)
recode age (3=1 "16-24") (1 2 4 = 0 "Other"), gen(age3)
recode age (4=1 "16-24") (1 2 3 = 0 "Other"), gen(age4)

recode race (1/4 12 = 1 "Asian") (5/11 13/16 = 0 "Other") (17=.), gen(asian)
recode race (5/7 = 1 "Black") (1/4 8/16 = 0 "Other") (17=.), gen(black)
recode race (8/11 = 1 "Mixed") (1/7 12/16 = 0 "Other") (17=.), gen(mixed)
recode race (13 = 1 "Other ethnicity") (1/12 14/16 = 0 "Other") (17=.), gen(ethnico)
recode race (14/16 = 1 "White") (1/13 = 0 "Other") (17=.), gen(white)

recode educ (1=1 "No qualification") (2/6 = 0 "Other") (7=.), gen(educ1)
recode educ (2=1 "O grade") (1 3/6 = 0 "Other") (7=.), gen(educ2)
recode educ (3=1 "A leveln") (1 2 4/6 = 0 "Other") (7=.), gen(educ3)
recode educ (4=1 "HNC/HND") (1/3 5 6 = 0 "Other") (7=.), gen(educ4)
recode educ (5=1 "BA") (1/4 6 = 0 "Other") (7=.), gen(educ5)
recode educ (6=1 "Higher degree") (1/5 = 0 "Other") (7=.), gen(educ6)

recode cov (1 2 = 1 "Covid+") (3 4 = 0 "Other") (5=.), gen(covpos)
recode cov (3 = 1 "Suspected") (1 2 4 = 0 "Other") (5=.), gen(covsusp)
recode cov (4 = 1 "No Covid") (1/3 = 0 "Other") (5=.), gen(covno)

replace covidaffect_1=0 if covidaffect_1==.
replace covidaffect_2=0 if covidaffect_2==.
replace covidaffect_3=0 if covidaffect_3==.
replace covidaffect_4=0 if covidaffect_4==.
replace covidaffect_5=0 if covidaffect_5==.
replace covidaffect_6=0 if covidaffect_6==.
replace covidaffect_7=0 if covidaffect_7==.
replace covidaffect_8=0 if covidaffect_8==.

tab covidaffect_1
tab covidaffect_2
tab covidaffect_3
tab covidaffect_4
tab covidaffect_5
tab covidaffect_6
tab covidaffect_7
tab covidaffect_8

rename covidaffect_1 nowork
rename covidaffect_5 food
rename covidaffect_7 hospital
rename covidaffect_8 death

keep male female nonbin age1-age4 asian black mixed ethnico white educ1-educ6 ///
area covpos covsusp covno pj_1-pj_3 bound1-bound3 na_1-na_3 ob_1-ob_3 coop_1-coop_3 ///
mfenforce1 mfenforce2 mfenforce3 mftrack1 mftrack2 mftrack3 mfexpress contactpol ///
contactcit contactvic victim covconc covidexp weight covpriv1-covpriv3 ///
nowork food hospital death

stata2mplus using "C:\Users\Krisztián\Desktop\LSE Postdoc\Covid-19\Data\Wave1\mfenforce_w1", replace

