/* Assigning a Library */
Libname Cookie '/home/anant.awasthi/LibHome';
run;

/* Specify the location of the Excel file */
filename cdata '/home/anant.awasthi/Data/Cookies-Production-Data.xlsx';
filename pdata '/home/anant.awasthi/Data/Production-Unit-Data.xlsx';

/* Use PROC IMPORT to import the Excel file */
proc import datafile=cdata 
		out=Cookie.cookiesdata /* Name of the SAS dataset to create */
		dbms=xlsx /* Specifies the database management system */
		replace;
	/* Replace existing dataset if it exists */
	/* If the Excel file has multiple sheets, you can specify the sheet using the sheet option */
	/* For example: sheet='Sheet1'; */
run;

proc import datafile=pdata 
		out=Cookie.productiondata /* Name of the SAS dataset to create */
		dbms=xlsx /* Specifies the database management system */
		replace;
	/* Replace existing dataset if it exists */
	/* If the Excel file has multiple sheets, you can specify the sheet using the sheet option */
	/* For example: sheet='Sheet1'; */
run;

/* ############################################################################################## */
/* ############################ Non-Parametric Statistical Inference ############################ */
/* ############################################################################################## */

/* Data Preperation */
data mean_comp;
	set cookie.COOKIESDATA;
	where Machineid in ('CNC105', 'CNC104');
run;

proc freq data=mean_comp;
	table machineid;
run;

/* Perform Wilcoxon signed-rank test */
proc univariate data=mean_comp mu0=100;
var weight;
run;

/* 

Documentation
Sign – 
The sign test is a simple nonparametric procedure to test the null hypothesis 
regarding the population median. It does not require that the sample is drawn from a normal distribution. 
It is used when we have a small sample from a nonnormal distribution. 
The statistic M is defined to be M=(N+-N–)/2 where N+ is the number of values
that are greater than Mu0 and N– is the number of values that are less than Mu0.
Values equal to Mu0 are discarded. Under the hypothesis that the population median is equal to Mu0, 
the sign test calculates the p-value for M using a binomial distribution.
The interpretation of the p-value is the same as for t-test

Signed Rank – 
The signed rank test is also known as the Wilcoxon test.
It is used to test the null hypothesis that the population median equals Mu0. 
It assumes that the distribution of the population is symmetric. 
The Wilcoxon signed rank test statistic is computed based on the rank sum and the numbers of observations 
that are either above or below the median. 
The interpretation of the p-value is the same as for the t-test.

 */


/* Perform Wilcoxon rank-sum test */
proc npar1way data=mean_comp wilcoxon;
   class Machineid;
   var weight;
run;



/* Data Prep */
data mean_comp;
	set cookie.COOKIESDATA;
	where Machineid in ('CNC105', 'CNC104', 'CNC101');
run;


/* SAS code for Kruskal-Wallis test */
/* Perform Kruskal-Wallis test */
proc npar1way data=mean_comp wilcoxon dscf;
   class Machineid;
   var weight;
run;


/* Wilcoxon Signed-Rank with SAS */
data paired_dataset;
input before after;
Diff = before-after;
datalines;
10 15
12 14
14 16
16 18
20 22
;
run;


proc univariate data=paired_dataset mu0=0;
   var Diff;
   ods select TestsForLocation;
run;