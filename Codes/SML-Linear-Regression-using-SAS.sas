
/* References */
/* https://stats.oarc.ucla.edu/sas/output/regression-analysis/ */
/* https://stats.oarc.ucla.edu/sas/webbooks/reg/ */

/* These data (hsb2demo) were collected on 200 high schools students and are scores on various tests, 
including science, math, reading and social studies (socst). 
The variable female is a dichotomous variable coded 1 if the student was female and 0 if male. */



/* Libname assignment */
libname SMLLR '/home/anant.awasthi/LibHome';
run;

libname modelrep '/home/anant.awasthi/ModelRepository';
run;

/* Examine Data */
proc contents data = SMLLR.hsb2demo;
run;

/* Have a quick look */
proc print data = SMLLR.hsb2demo (obs=10);
run;

/* ----------------- Fitting the model ----------------- */
/* Fitting the basic  model */
proc reg data = SMLLR.hsb2demo; 
model science = math female socst read / clb VIF;
run;
quit;

/* Saving the fitted Model*/
proc reg data = SMLLR.hsb2demo outest=modelrep.lrm_hsb; 
model science = math female socst read / clb VIF;
run;
quit;

/* ----------------- Drawing Inference from fitted Model ----------------- */
/* Score the new dataset using the fitted model */



