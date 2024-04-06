/* Assigning a Library */
Libname PMTDATA '/home/anant.awasthi/LibHome';
run;

/* Specify the location of the Excel file */
filename cdata '/home/anant.awasthi/Data/Placement_Data_2015-2020.xlsx';

/* Use PROC IMPORT to import the Excel file */
proc import datafile=cdata 
		out=PMTDATA.PlacementAnalysis /* Name of the SAS dataset to create */
		dbms=xlsx /* Specifies the database management system */
		replace;
	/* Replace existing dataset if it exists */
	/* If the Excel file has multiple sheets, you can specify the sheet using the sheet option */
	/* For example: sheet='Sheet1'; */
run;

/* Extracting top 10 rows */
proc print data=PMTDATA.PlacementAnalysis (obs=10);
run;

/* Schema */
/* Obs	InstituteID	    Year	Work_Experience	Work_Experience_Group	Placement_Package	Placement_Group */
/* 1	INS-CAT3-105	2019	4	            WE01	                730000	            G1 */

/* Examining the dataset */
proc contents data=PMTDATA.PlacementAnalysis;
run;

/* -------------------------------------------------------------------------------------------------------------------------- */
/* Univariate Analysis - Data */
/* -------------------------------------------------------------------------------------------------------------------------- */

/* InstituteID  */
proc freq data = PMTDATA.PlacementAnalysis;
table InstituteID;
run;

/* Year  */
proc freq data = PMTDATA.PlacementAnalysis;
table Year;
run;

/* Work_Experience  */
proc means data = PMTDATA.PlacementAnalysis;
var Work_Experience;
run;

proc univariate data = PMTDATA.PlacementAnalysis;
var Work_Experience;
run;

/* Work_Experience_Group  */
proc freq data = PMTDATA.PlacementAnalysis;
table Work_Experience_Group;
run;

/* Work_Experience_Group  */
proc freq data = PMTDATA.PlacementAnalysis;
table Placement_Group;
run;

/* Work_Experience  */
proc means data = PMTDATA.PlacementAnalysis;
where Placement_Group ^= 'DEP';
var Placement_Package;
run;

proc univariate data = PMTDATA.PlacementAnalysis;
where Placement_Group ^= 'DEP';
var Placement_Package;
run;

/* -------------------------------------------------------------------------------------------------------------------------- */
/* Bi-Variate Analysis - Data */
/* -------------------------------------------------------------------------------------------------------------------------- */

proc freq data = PMTDATA.PlacementAnalysis;
table InstituteID*Year / norow nopercent;
run;

proc freq data = PMTDATA.PlacementAnalysis;
table InstituteID*Year / nocol nopercent;
run;

