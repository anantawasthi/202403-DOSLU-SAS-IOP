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

/* Introduction to Proc Freq */
/* Univariate Frequncey Table */
PROC Freq data=cookie.COOKIESDATA;
	TABLE MachineID;
RUN;

PROC Freq data=cookie.COOKIESDATA;
	TABLE LotNumber;
RUN;

/* Cross Table */
PROC Freq data=cookie.COOKIESDATA;
	TABLE LotNumber*MachineID / norow ncol nopercent 
		out=cookie.machineanalysis_output_01;
	title 'My Machine and Lot number analysis' RUN;

	/* Analysis result export */
	/* PROC EXPORT to export dataset to Excel */
proc export data=cookie.machineanalysis_output_01 outfile='/home/anant.awasthi/Outputs/Lot_and_machine_Analysis.xlsx' /* Output Excel file path */
	dbms=xlsx /* Specifies the file type as Excel */
	replace;
	/* Replace existing file if it exists */
run;

/* PROC Means Explaination */
PROC means data=cookie.COOKIESDATA;
	var Weight;
run;

PROC means data=cookie.COOKIESDATA;
	var Weight;
	class MachineID;
run;

PROC means data=cookie.COOKIESDATA;
	var Weight;
	class MachineID LotNumber;
run;

PROC means data=cookie.COOKIESDATA;
	var Weight;
	class MachineID LotNumber;
	output out=weight_analysis /autoname;
run;

/* Define the ODS Excel destination */
ods excel file="/home/anant.awasthi/Outputs/summary_stats.xlsx";

PROC means data=cookie.COOKIESDATA;
	var Weight;
	class MachineID LotNumber;
	output out=weight_analysis /autoname;
	Title 'Weight and Machine Analysis';
run;

ods excel close;

/* PROC Univariate */
proc univariate data=cookie.COOKIESDATA;
	var Weight;
	histogram / normal;
run;

/* PROC SURVEYSELECT to generate a simple random sample */
proc surveyselect data=cookie.COOKIESDATA /* Specify your dataset */
	method=srs /* Simple Random Sampling method */
	sampsize=50 /* Sample size */
	out=sample /* Output dataset containing the sample */;
run;

/* Display the sample dataset */
proc print data=sample;
run;

/* ############################################################################################## */
/* ################################## Statistical Inference ##################################### */
/* ############################################################################################## */
/* Data Preperation */
data mean_comp;
	set cookie.COOKIESDATA;
	where Machineid in ('CNC105', 'CNC104');
run;

proc freq data=mean_comp;
	table machineid;
run;

/* One Sample T-Test */
proc ttest data=mean_comp h0=100;
	var weight;

	/* Specify the variable you want to test */
	/* Specify options for the test */
	ods output ttests=results;

	/* Output the results to a dataset */
run;

/* Independent Sample T Test */
proc ttest data=mean_comp;
	class Machineid;

	/* Specify the grouping variable */
	var weight;

	/* Specify the continuous variable */
	ods output ttests=results;

	/* Output the results to a dataset */
run;

/* Performing ANOVA */
data mean_comp;
	set cookie.COOKIESDATA;
	where Machineid in ('CNC105', 'CNC100', 'CNC104');
run;

proc anova data=mean_comp;
	class Machineid;

	/* Specify the grouping variable */
	model weight=Machineid;

	/* Specify the dependent variable and the grouping variable */
	means Machineid / hovtest=levene;

	/* Optionally test for equality of variances */
	run;

	/* Performing ANOVA */
proc glm data=mean_comp;
	class Machineid;

	/* Specify the grouping variable */
	model weight=Machineid;

	/* Specify the dependent variable and the grouping variable */
	lsmeans Machineid / pdiff;

	/* Perform post hoc tests using the LSMEANS statement with the PDIFF option */
	run;

	/* Prepare data */
data your_dataset;
	input before after;
	datalines;
10 15
12 14
14 16
16 18
20 22
;
run;

/* Performing paired t-test */
proc ttest data=your_dataset;
	paired before*after;

	/* Specify the paired variables */
run;