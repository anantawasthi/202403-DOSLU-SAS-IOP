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


/* Fitting Decision Tree Model*/

proc hpsplit data=SMLLR.binary;
  partition fraction(validate=0.3);
  target ADMIT;
  input gre gpa rank;
run;

