/* https://stats.oarc.ucla.edu/sas/dae/logit-regression/ */


/* Libname assignment */
libname SMLLR '/home/anant.awasthi/LibHome';
run;

libname modelrep '/home/anant.awasthi/ModelRepository';
run;

/* Examine Data */
proc contents data = SMLLR.binary;
run;

/* Have a quick look */
proc print data = SMLLR.binary (obs=10);
run;


/* Fitting Logistic Regression descending*/
proc logistic data=SMLLR.binary descending;
  class rank / param=ref ;
  model admit = gre gpa rank;
run;

proc logistic data=SMLLR.binary descending;
  class rank (ref='1');
  model admit = gre gpa rank;
run;

proc logistic data=SMLLR.binary outmodel=modelrep.LgRM_model descending;
  class rank (ref='1');
  model admit = gre gpa rank;
run;