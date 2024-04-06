/* Assigning a Library */
Libname LKOCAN '/home/anant.awasthi/LibHome';
run;

/* Specify the location of the Excel file */
filename cdata '/home/anant.awasthi/Data/LKO-OPD-Cancer-Exposure-Data.xlsx';

/* ------------------------------------------------------------------- */
/* Data Details */
/* ------------------------------------------------------------------- */
/* Status	Definition */
/* NSM		Never Smoked */
/* OSM		Occasionally Smokes */
/* SMK		Smoker */
/* ------------------------------------------------------------------- */
/* Exposure-Code	Definition */
/* 1				Cancer-Exposure */
/* 0 				No-Exposure */
/* ------------------------------------------------------------------- */

/* Use PROC IMPORT to import the Excel file */
proc import datafile=cdata 
		out=LKOCAN.cancerdata /* Name of the SAS dataset to create */
		dbms=xlsx /* Specifies the database management system */
		replace;
		SHEET="Data";
	/* Replace existing dataset if it exists */
	/* If the Excel file has multiple sheets, you can specify the sheet using the sheet option */
	/* For example: sheet='Sheet1'; */
run;


/* Overview of Data */
Proc contents data = LKOCAN.cancerdata;
run;

/* Univariate Frequncey Table - Patient (Smoker Status) Distribution */
PROC Freq data=LKOCAN.cancerdata;
	TABLE Patient_Tob_Con_Status;
RUN;

/* Univariate Frequncey Table - Cancer Distribution */
PROC Freq data=LKOCAN.cancerdata;
	TABLE Patient_Can_Exposure;
RUN;


/* Cross Table */

ods excel file="/home/anant.awasthi/Outputs/Cancer_Data_Analysis.xlsx";
PROC Freq data=LKOCAN.cancerdata;
	TABLE Patient_Tob_Con_Status*Patient_Can_Exposure / nocol nopercent ; 
	title 'Smoking Status and Cancer Exposure Data Analysis';
	RUN;

ods excel close;

/* Chi-Square Test for Association */
/* Reference - https://stats.oarc.ucla.edu/sas/output/proc-freq/ */

ods excel file="/home/anant.awasthi/Outputs/Cancer_Data_Analysis_Chi_Square_Results.xlsx";
PROC Freq data=LKOCAN.cancerdata;
	TABLE Patient_Tob_Con_Status*Patient_Can_Exposure / chisq nocol nopercent ; 
	title 'Association analysis between Smoking Status and Cancer Exposure';
	RUN;

ods excel close;




