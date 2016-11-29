##################################################################################################################################
#' Cylinder Bands
#' 
#' @name bands
#'
#'
#' @description This dataset is related with process delays known as cylinder banding in rotogravure printing.
#' 
#' The full dataset was described and analyzed in [Moro et al., 2011]., see \code{source} section.
#'
#'
#' @usage data(bands)
#' 
#' 
#' @format \code{bands} is a tbl data frame with 540 observations on 40 variables.
#' 
#'  
#' @details 
#' The 40 variables are organized as follows.
#' 
#' \itemize{
#' \item \code{timestamp} (numeric from 19900330 to 19941010);
#' \item \code{cylinder_number} (character);
#' \item \code{customer} (character);
#' \item \code{job_number} (numeric from 23040 to 88231) 
#' \item \code{grain_screened} (factor with 2 levels: YES, NO);
#' \item \code{ink_color} (factor with 1 level: KEY);
#' \item \code{proof_on_ctd_ink} (factor with 2 levels: YES, NO);
#' \item \code{blade_mfg} (factor with 2 levels: BENTON, UDDEHOLM);
#' \item \code{cylinder_division} (factor with 1 level: GALLATIN);
#' \item \code{paper_type} (factor with 3 level: UNCOATED, COATED, SUPER);
#' \item \code{ink_type} (factor with 3 level: UNCOATED, COATED, COVER); 
#' \item \code{direct_steam} (factor with 2 levels: YES, NO);
#' \item \code{solvent_type} (factor with 3 level: LINE, NAPTHA, XYLOL);
#' \item \code{type_on_cylinder} (factor with 2 levels: YES, NO);
#' \item \code{press_type} (factor with 4 levels: ALBERT70, MOTTER70, MOTTER94, WOODHOE70);
#' \item \code{press} (numeric from 802 to 828)
#' \item \code{unit_number}: printing unit (numeric: 1-10)
#' \item \code{cylinder_size} (factor with 3 levels: CATALOG, SPIEGEL, TABLOID);
#' \item \code{paper_mill_location} (factor with 5 levels: CANADIAN, MIDEUROPEAN, NORTHUS, SCANDANAVIAN, SOUTHUS);
#' \item \code{plating_tank} (numeric: 1910, 1911);
#' \item \code{proof_cut} measured in percentage (numeric: 0-100);
#' \item \code{viscosity} measured in percentage (numeric: 0-100);
#' \item \code{caliper} measured in percentage (numeric: 0-1);
#' \item \code{ink_temperature} measured in degrees Fahrenheit (numeric: 5-30);
#' \item \code{humidity} measured in percentage (numeric: 5-105);
#' \item \code{roughness} measured in microns (numeric: 0-2);
#' \item \code{blade_pressure} measured in pounds (numeric: 10-75);
#' \item \code{varnish_pct} measured in percentage (numeric: 0-100);
#' \item \code{press_speed} measured in feet per minute (numeric: 0-4000);
#' \item \code{ink_pct} measured in percentage (numeric: 0-100);
#' \item \code{solvent_pct} measured in percentage (numeric: 0-100);
#' \item \code{esa_voltage} measured in kilovolts (numeric: 0-16);
#' \item \code{esa_amperage} measured in milliamps (numeric: 0-10);
#' \item \code{wax} measured in gallons (numeric: 0-4);
#' \item \code{hardener} measured in gallons (numeric: 0-3.0);
#' \item \code{roller_durometer} (numeric: 15-120);
#' \item \code{current_density} measured in amperes per square decimeter (numeric: 20-50);
#' \item \code{anode_space_ratio} (numeric: 70-130);
#' \item \code{chrome_content} (numeric: 80-120);
#' \item \code{band_type} (factor with 2 levels: BAND, NOBAND).
#' }
#' 
#' 
#' @source This dataset is publicly available at \href{http://archive.ics.uci.edu/ml/datasets/Cylinder+Bands}{UCI Machine Learning repository}.
#' 
#' Please include this citation if you plan to use this dataset:\cr
#' Lichman, M. (2013). UCI Machine Learning Repository [\url{http://archive.ics.uci.edu/ml}]. Irvine, CA: University of California, School of Information and Computer Science.
#' 
#' The dataset was created and donated on 08 Jan 1995 to \href{http://archive.ics.uci.edu/ml/datasets/Cylinder+Bands}{UCI Machine Learning repository} by:\cr
#' Bob Evans 
#' RR Donnelley & Sons Co. 
#' Gallatin Division 
#' 801 Steam Plant Rd 
#' Gallatin, Tennessee 37066-3396 
#' (615) 452-5170 
NULL
##################################################################################################################################


##################################################################################################################################
#' Marketing Campaigns of a Portuguese Banking Institution
#' 
#' 
#' @name bank
#' 
#' 
#' @description This dataset is related with direct marketing campaigns of a Portuguese
#' banking institution. The marketing campaigns were based on phone calls. 
#' Often, more than one contact to the same client was required, in order to access if the product (bank term deposit) would be ('yes') or not ('no') subscribed. 
#' 
#' The full dataset was described and analyzed in [Moro et al., 2011]., see \code{source} section.
#' 
#'  
#' @usage data(bank) 
#' 
#' 
#' @format \code{bank} is a tbl data frame with 45211 observations on 20 variables.
#' 
#' The data is ordered by call id (and also by date, from May 2008 to November 2010). 
#' 
#' 
#' @details 
#' The 20 variables are organized as follows.
#' 
#' Bank client data:
#' \itemize{
#' \item \code{id} phone call id (integer: from 1 to 45211);
#' \item \code{age} age (integer);
#' \item \code{job} type of job (factor with 12 levels: admin., unknown, unemployed, management, housemaid, entrepreneur, student,  blue-collar, self-employed, retired, technician, services);
#' \item \code{marital} marital status (factor with 3 levels: married, divorced, single). divorced means divorced or widowed;
#' \item \code{education} education (factor with 4 levels: unknown, secondary, primary, tertiary);
#' \item \code{default} has credit in default? (factor with 2 levels: yes, no);
#' \item \code{balance} average yearly balance, in euros (integer);
#' \item \code{housing} has housing loan? (factor with 2 levels: yes, no);
#' \item \code{loan} has personal loan? (factor with 2 levels: yes, no).
#' }
#' Related with the last contact of the current campaign:
#' \itemize{
#' \item \code{contact} contact communication type (factor with 3 levels: unknown, telephone, cellular);
#' \item \code{day} last contact day of the month (integer);
#' \item \code{month} last contact month of year (factor with 12 levels: jan, feb, mar, ..., nov, dec);
#' \item \code{year} last contact year (integer: 2008, 2009, 2010);
#' \item \code{date} last contact date (\code{POSIXct} date);
#' \item \code{duration} last contact duration, in seconds (integer);
#' \item \code{y} has the client subscribed a term deposit? (factor with 2 levels: yes, no).
#' }
#' Other attributes:
#' \itemize{
#' \item \code{campaign} number of contacts performed during this campaign and for this client (integer: it includes last contact);
#' \item \code{pdays} number of days that passed by after the client was last contacted from a previous campaign (integer). -1 means client who was not previously contacted;
#' \item \code{previous} number of contacts performed before this campaign and for this client (integer);
#' \item \code{poutcome} outcome of the previous marketing campaign (factor with 4 levels: "unknown", "other", "failure", "success").
#' }
#' 
#' 
#' @source This dataset is publicly available for research at \href{http://archive.ics.uci.edu/ml/datasets/Bank+Marketing}{UCI Machine Learning repository}.
#' The details are described in [Moro et al., 2011]. 
#' 
#' Please include this citation if you plan to use this dataset:\cr
#' [Moro et al., 2011] S. Moro, R. Laureano and P. Cortez. Using Data Mining for Bank Direct Marketing: An Application of the CRISP-DM Methodology.  
#' In P. Novais et al. (Eds.), \emph{Proceedings of the European Simulation and Modelling Conference - ESM'2011}, pp. 117-121, Guimarães, Portugal, October, 2011. EUROSIS.\cr
#' Available at \url{http://hdl.handle.net/1822/14838}.
NULL
##################################################################################################################################


##################################################################################################################################
#' Swiss Banknotes 
#' 
#' 
#' @name banknotes
#' 
#' 
#' @description This dataset deals with 200 old Swiss 1,000-franc banknotes classified by dimensions (6 numerical characteristics) and type (genuine/counterfeit).
#' The first 100 banknotes are genuine, the last 100 are counterfeit.
#' 
#'  
#' @usage data(banknotes)
#' 
#' 
#' @format \code{banknotes} is a tbl data frame with 200 observations on 7 variables.
#' 
#' 
#' @details 
#' The 7 variables of the \code{banknotes} tbl data frame are the following ones:
#' \itemize{
#' \item \code{length} length of the banknote (numeric);
#' \item \code{left} height of the banknote, measured on the left (cu.in.) (numeric);
#' \item \code{right} height of the banknote, measured on the right (numeric);
#' \item \code{bottom} distance of inner frame to the lower border (numeric);
#' \item \code{top} distance of inner frame to the upper border (numeric);
#' \item \code{diagonal} length of the diagonal (numeric);
#' \item \code{type} if the banknote is genuine or counterfeit (Factor).
#' }
#' 
#' 
#' @source Härdle and Simar, Applied Multivariate Statistical Analysis, 3rd ed., Springer, 2012
NULL
##################################################################################################################################


##################################################################################################################################
#' Bimetal Dataset in Phase I
#' 
#' 
#' @name bimetal1
#' 
#' 
#' @description The \code{bimetal1} data was extracted from the analogous data frame of package \code{MSQC}. 
#' The dataset contains measurements of the deflection, the curvature, the resistivity and the hardness in low 
#' and high expansion sides, from brass and steel bimetal thermostats. The manufacturing process is assumed to be "in-control".
#' 
#'  
#' @usage data(bimetal1)
#' 
#' 
#' @format \code{bimetal1} is a tbl data frame with 28 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{bimetal1} tbl data frame are the following ones:
#' \itemize{
#' \item \code{deflection} the deflection level in 10^-6 1/Kl (numeric);
#' \item \code{curvature} the curvature level in 10^-6 1/K (numeric);
#' \item \code{resistivity} the resistivity level in 10 ^-1ohm x mm^2/m (numeric);
#' \item \code{Hardness.low.side} the hardness of the low expansion side in 10 N/mm^2 (numeric);
#' \item \code{Hardness.high.side} the hardness of the high expansion side in 10 N/mm^3 (numeric).
#' }
#' 
#' 
#' @seealso the complete \code{bimetal1} help page is in the \code{MSQC} package: \code{\link[MSQC]{bimetal1}}
NULL
##################################################################################################################################


##################################################################################################################################
#' Boston Houses
#' 
#' 
#' @name bostonhousing
#' 
#' 
#' @description The \code{bostonhousing} data deals with 506 houses in Boston classified by 13 numerical characteristics
#' (age, tax, etc.) and one categorical characteristic (chas).
#' 
#'  
#' @usage data(bostonhousing)
#' 
#' 
#' @format \code{bostonhousing} is a tbl data frame with 506 observations on 14 variables.
#' 
#' 
#' @details 
#' The 14 variables of the \code{bostonhousing} tbl data frame are the following ones:
#' \itemize{
#' \item \code{crim} per capita crime rate by town (numeric)
#' \item \code{zn} proportion of residential land zoned for lots over 25,000 sq.ft. (numeric)
#' \item \code{indus} proportion of non-retail business acres per town (numeric)
#' \item \code{chas} Charles River dummy variable (= 1 if tract bounds river; 0 otherwise) (numeric)
#' \item \code{nox} nitrogen oxides concentration (parts per 10 million) (numeric)
#' \item \code{rm} average number of rooms per dwelling (numeric)
#' \item \code{age} proportion of owner-occupied units built prior to 1940 (numeric)
#' \item \code{dis} weighted mean of distances to five Boston employment centres (numeric)
#' \item \code{rad} index of accessibility to radial highways (numeric)
#' \item \code{tax} full-value property-tax rate per $10,000 (numeric)
#' \item \code{ptratio} pupil-teacher ratio by town (numeric)
#' \item \code{black} 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town (numeric)
#' \item \code{lstat} lower status of the population (percent)  (numeric)
#' \item \code{medv} median value of owner-occupied homes in $1000 (numeric)
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Default of credit card clients
#' 
#' 
#' @name default
#' 
#' 
#' @description The \code{default} data contains information about customers default payments in Taiwan.
#' 
#'  
#' @usage data(default)
#' 
#' 
#' @format \code{default} is a tbl data frame with 30000 observations on 25 variables.
#' 
#' 
#' @details 
#' The 25 variables of the \code{default} tbl data frame are the following ones:
#' \itemize{
#' \item \code{ID} (numeric);
#' \item \code{LIMIT_BAL} Amount of the given credit (NT dollar): it includes both the individual consumer credit and his/her family (supplementary) credit (numeric)
#' \item \code{SEX} Gender (factor with 2 levels: \code{1} (Male) and \code{2}(Female));
#' \item \code{EDUCATION} Education (factor with 7 levels: \code{0}, \code{1}, \code{2}, \code{3}, \code{4}, \code{5} and \code{6});
#' \item \code{MARRIAGE} Marital status (factor with 4 levels: \code{0}, \code{1}, \code{2} and \code{3});
#' \item \code{AGE} Age (year) (numeric);
#' \item \code{PAY_0} History of past payment: the repayment status in September, 2005 (numeric);
#' \item \code{PAY_2} History of past payment: the repayment status in August, 2005 (numeric);
#' \item \code{PAY_3} History of past payment: the repayment status in July, 2005 (numeric);
#' \item \code{PAY_4} History of past payment: the repayment status in June, 2005 (numeric);
#' \item \code{PAY_5} History of past payment: the repayment status in May, 2005 (numeric);
#' \item \code{PAY_6} History of past payment: the repayment status in April, 2005 (numeric);
#' \item \code{BILL_AMT1} Amount of bill statement (NT dollar): amount of bill statement in September, 2005 (numeric);
#' \item \code{BILL_AMT2} Amount of bill statement (NT dollar): amount of bill statement in August, 2005(numeric);
#' \item \code{BILL_AMT3} Amount of bill statement (NT dollar): amount of bill statement in July, 2005 (numeric);
#' \item \code{BILL_AMT4} Amount of bill statement (NT dollar): amount of bill statement in June, 2005 (numeric);
#' \item \code{BILL_AMT5} Amount of bill statement (NT dollar): amount of bill statement in May, 2005 (numeric);
#' \item \code{BILL_AMT6} Amount of bill statement (NT dollar): amount of bill statement in April, 2005 (numeric);
#' \item \code{PAY_AMT1} Amount of previous payment (NT dollar): amount paid in September (numeric);
#' \item \code{PAY_AMT2} Amount of previous payment (NT dollar): amount paid in August (numeric);
#' \item \code{PAY_AMT3} Amount of previous payment (NT dollar): amount paid in July (numeric);
#' \item \code{PAY_AMT4} Amount of previous payment (NT dollar): amount paid in June (numeric);
#' \item \code{PAY_AMT5} Amount of previous payment (NT dollar): amount paid in May (numeric);
#' \item \code{PAY_AMT6} Amount of previous payment (NT dollar): amount paid in April (numeric);
#' \item \code{default_payment} default payment next month (factor with 2 levels: \code{0} (No) and \code{1} (Yes));
#' }
#' 
#' @source I-Cheng Yeh, Department of Information Management, Chung Hua University, Taiwan. (2) Department of Civil Engineering, Tamkang University, Taiwan.
NULL
##################################################################################################################################


##################################################################################################################################
#' Diabetes Patients Records
#' 
#' 
#' @name diabetes
#' 
#' 
#' @description Insulin Dependent Diabetes Mellitus (IDDM) data for the AAAI Spring Symposium (1994).
#' 
#'  
#' @usage data(diabetes)
#' 
#' 
#' @format \code{diabetes} is a tbl data frame with 30264 observations on 5 variables.
#' 
#' 
#' @details 
#' Diabetes patient records were obtained from two sources: an automatic electronic recording device and paper records. The automatic device had an internal clock to timestamp events, whereas the paper records only provided "logical time" slots (breakfast, lunch, dinner, bedtime).  For paper records, fixed times were assigned to breakfast (08:00), lunch (12:00), dinner (18:00), and bedtime (22:00).  Thus paper records have fictitious uniform recording times whereas electronic records have more realistic time stamps. 
#' 
#' Data has five variables:
#' \itemize{
#' \item \code{patient} id (character), this correspond to a single file on original data
#' \item \code{date} in MM-DD-YYYY format (factor)
#' \item \code{time} in XX:YY format (factor)
#' \item \code{code} indicates a task, according to the following list (integer)
  #' \itemize{  
  #' \item 33 = Regular insulin dose
  #' \item 34 = NPH insulin dose
  #' \item 35 = UltraLente insulin dose
  #' \item 48 = Unspecified blood glucose measurement
  #' \item 57 = Unspecified blood glucose measurement
  #' \item 58 = Pre-breakfast blood glucose measurement
  #' \item 59 = Post-breakfast blood glucose measurement
  #' \item 60 = Pre-lunch blood glucose measurement
  #' \item 61 = Post-lunch blood glucose measurement
  #' \item 62 = Pre-supper blood glucose measurement
  #' \item 63 = Post-supper blood glucose measurement
  #' \item 64 = Pre-snack blood glucose measurement
  #' \item 65 = Hypoglycemic symptoms
  #' \item 66 = Typical meal ingestion
  #' \item 67 = More-than-usual meal ingestion
  #' \item 68 = Less-than-usual meal ingestion
  #' \item 69 = Typical exercise activity
  #' \item 70 = More-than-usual exercise activity
  #' \item 71 = Less-than-usual exercise activity
  #' \item 72 = Unspecified special event
#' }
#' \item \code{value} insuline value (character)
#' }
#' 
#' @source This dataset is publicly available at \href{http://archive.ics.uci.edu/ml/datasets/Diabetes}{UCI Machine Learning repository}.
NULL
##################################################################################################################################


##################################################################################################################################
#' Drug Rates Correlations 
#' 
#' 
#' @name druguse
#' 
#' 
#' @description The \code{druguse} data contains the correlation matrix among rates (recorded on a 5-point scale)
#' for a sample of 1,634 students in the seventh to ninth grades in 11 schools in the greater metropolitan area
#' of Los Angeles. Each participant completed a questionnaire about the number of times a particular substance had ever been used.
#' 
#'  
#' @usage data(druguse)
#' 
#' 
#' @format \code{druguse} is a 13 x 13 correlation matrix.
#' 
#' 
#' @details 
#' The 13 substances asked about, which are also the row and columns names of the matrix, were the following ones:
#' \itemize{
#' \item \code{cigarettes};
#' \item \code{beer};
#' \item \code{wine};
#' \item \code{liquor};
#' \item \code{cocaine};
#' \item \code{tranquillizers};
#' \item \code{drug store medications} used to get high;
#' \item \code{heroin} and other opiates;
#' \item \code{marijuana};
#' \item \code{hashish};
#' \item \code{inhalants} (glue, gasoline, etc.);
#' \item \code{hallucinogenics} (LSD, mescaline, etc.);
#' \item \code{amphetamine} stimulants.
#' }
#' 
#' 
#' @source Everitt, B. and Hothorn, T., *An Introduction to Applied Multivariate Analysis with `R`*, Springer, 2011
NULL
##################################################################################################################################


##################################################################################################################################
#' Most Paid CEOs in U.S. 
#' 
#' 
#' @name forbes94
#' 
#' 
#' @description The \code{forbes94} data deals with the compensation received in 1994 by the 800 most paid CEOs in US
#' (This dataset comes from a ranking published by the Forbes newspaper in the same year).
#' 
#'  
#' @usage data(forbes94)
#' 
#' 
#' @format \code{forbes94} is a tbl data frame with 800 observations on 30 variables.
#' 
#' 
#' @details 
#' The 30 variables of the \code{forbes94} tbl data frame are the following ones:
#' \itemize{
#' \item \code{TotalComp} (numeric)
#' \item \code{WideIndustry} Factor w/ 19 levels
#' \item \code{Company} Factor w/ 800 levels
#' \item \code{CEO} Factor w/ 796
#' \item \code{CityofBirth} Factor w/ 402 levels
#' \item \code{StateofBirth} Factor w/ 51 levels
#' \item \code{Age} (numeric)
#' \item \code{Undergrad} Factor w/ 262 levels
#' \item \code{UGDegree} Factor w/ 25 levels 
#' \item \code{UGDate} (numeric)
#' \item \code{AgeOfUnder} (numeric)
#' \item \code{Graduate}Factor w/ 129 levels
#' \item \code{GradDegree} Factor w/ 20 levels
#' \item \code{MBA} (numeric)
#' \item \code{MasterPhd} (numeric)
#' \item \code{G_date} (numeric)
#' \item \code{AgeOfGradu} (numeric)
#' \item \code{YearsFirm} (numeric)
#' \item \code{YearsCEO} (numeric)
#' \item \code{Salary} (numeric)
#' \item \code{Bonus} (numeric)
#' \item \code{Other} (numeric)
#' \item \code{StGains} (numeric)
#' \item \code{Compfor5Yrs} (numeric)
#' \item \code{StockOwned} (numeric)
#' \item \code{Sales} (numeric)
#' \item \code{Profits} (numeric)
#' \item \code{ReturnOver5Yrs} (numeric)
#' \item \code{Industry} (numeric)
#' \item \code{IndustryCode} (numeric)
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' G1res
#' 
#' 
#' @name g1res
#' 
#' 
#' @description The \code{g1res} data was ......
#' 
#'  
#' @usage data(g1res)
#' 
#' 
#' @format \code{g1res} is a tbl data frame with 19 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{g1res} tbl data frame are the following ones:
#' \itemize{
#' \item \code{V1} (numeric);
#' \item \code{V2} (numeric);
#' \item \code{V3} (numeric).
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' German Credit Cards 
#' 
#' 
#' @name german
#' @aliases germannumeric germanstring
#' 
#' 
#' @description The \code{german} data deals with a sample of 1,000 customers which apply for a credit card. Some have defaulted
#' (Bad class) and other not (Good) on the credit card. 20 further characteristics about them or their credit card have been measured. 
#' 
#'  
#' @usage data(german)
#' 
#' 
#' @format \code{german} is a tbl data frame with 1000 observations on 21 variables.
#' 
#' 
#' @details 
#' The 21 variables of the \code{german} tbl data frame are the following ones:
#' \itemize{
#' \item \code{StatusAccount} Factor w/ 4 levels
#' \item \code{Duration} (numeric)
#' \item \code{CreditHistory} Factor w/ 5 levels
#' \item \code{Purpose} Factor w/ 10 levels
#' \item \code{CreditAmount} (numeric)
#' \item \code{SavingsAccountBonds} Factor w/ 5 levels
#' \item \code{EmployedSince} Factor w/ 5 levels
#' \item \code{RatePercIncome} (numeric)
#' \item \code{StatusAndSex} Factor w/ 5 levels
#' \item \code{OtherBebtorsGarants} Factor w/ 3 levels
#' \item \code{ResidenceSince} (numeric)
#' \item \code{Property} Factor w/ 4 levels
#' \item \code{AgeYears} (numeric)
#' \item \code{OtherInstallPlans} Factor w/ 3 levels
#' \item \code{Housing} Factor w/ 3 levels
#' \item \code{NumberOfCredits} (numeric)
#' \item \code{Job} Factor w/ 4 levels
#' \item \code{NumberPeopleMaintained} (numeric)
#' \item \code{Telephone} Factor w/ 2 levels
#' \item \code{ForeignWorker} Factor w/ 2 levels
#' \item \code{Class} Factor w/ 2 levels
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Life Expectations
#' 
#' 
#' @name life
#' 
#' 
#' @description The \code{life} data contains life expectations in years at birth, 25, 50 and 75 years for men and women in 31 Countries or regions.
#' 
#'  
#' @usage data(life)
#' 
#' 
#' @format \code{life} is a tbl data frame with 31 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{life} tbl data frame are the following ones:
#' \itemize{
#' \item \code{country} (character);
#' \item \code{m0} life expectation in years for men at birth (numeric);
#' \item \code{m25} life expectation in years for men at 25 (numeric);
#' \item \code{m50} life expectation in years for men at 50 (numeric);
#' \item \code{m75} life expectation in years for men at 75 (numeric);
#' \item \code{m0} life expectation in years for women at birth (numeric);
#' \item \code{m25} life expectation in years for women at 25 (numeric);
#' \item \code{m50} life expectation in years for women at 50 (numeric);
#' \item \code{m75} life expectation in years for women at 75 (numeric).
#' }
#' 
#' 
#' @source Everitt, B. and Hothorn, T., An Introduction to Applied Multivariate Analysis with R, Springer, 2011
NULL
##################################################################################################################################


##################################################################################################################################
#' Data on Italian Districts
#' 
#' 
#' @name italia
#' 
#' 
#' @description The \code{italia} dataset is related with information on the 8003 Italian districts ("comuni") updated at 2016-01-01. 
#' In particular information on "province", "regioni, "ripartizioni" ("major" Italian districts) related to "comuni" is available.
#' 
#'  
#' @usage data(italia) 
#' 
#' 
#' @format \code{italia} is a tbl data frame with 8003 observations on 14 variables.
#' 
#' 
#' @details 
#' The 14 variables of the \code{italia} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cod_comune} codes of the Italian "comuni" (character);
#' \item \code{comune} names of the Italian "comuni" (character);
#' \item \code{comune_cap_prov} if a "comune" is the administrative center of the "provincia" (logical);
#' \item \code{pop_legale} legal population living in the "comuni" at the last "Censimento" (2011-10-09) (integer);
#' \item \code{progr_comune} progressive codes of the Italian "comuni" (it restarts from 1 for each "provincia") (character);
#' \item \code{cod_provincia} codes of the Italian "province"; note that \code{cod_comune} is \code{cod_provincia} pasted to \code{progr_comune} (character);
#' \item \code{provincia} names of the Italian "province" (character);
#' \item \code{sigla_auto} automotive initials ("targa automobilistica") of the Italian "province" (character);
#' \item \code{cod_citta_metro} codes of the Italian "città metropolitane" (character);
#' \item \code{citta_metro} names of the Italian "città metropolitane" (character);
#' \item \code{cod_regione} codes of the Italian "regioni" (character);
#' \item \code{regione} names of the Italian "regioni" (character);
#' \item \code{cod_rip_geo} codes of the Italian "ripartizioni geografiche" (character);
#' \item \code{rip_geo} names of the Italian "ripartizioni geografiche" (character).
#' }
#' 
#' 
#' @source This dataset was downloaded in the Istat website: \href{http://www.istat.it/it/archivio/6789}{Istituto nazionale di statistica (Istat)}.
NULL
##################################################################################################################################

##################################################################################################################################
#' Data on Italian Districts (Comuni)
#' 
#' 
#' @name comuni
#' 
#' 
#' @description The \code{comuni} dataset is related with information on the 8003 Italian districts ("comuni") updated at 2016-01-01. 
#' In particular information on "province", "regioni, "ripartizioni" ("major" Italian districts) related to "comuni" is available.
#' 
#'  
#' @usage data(comuni) 
#' 
#' 
#' @format \code{comuni} is a tbl data frame with 8003 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{italia} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cod_comune} codes of the Italian "comuni" (character);
#' \item \code{comune} names of the Italian "comuni" (character);
#' \item \code{comune_cap_prov} if a "comune" is the administrative center of the "provincia" (logical);
#' \item \code{pop_legale} legal population living in the "comuni" at the last "Censimento" (2011-10-09) (integer);
#' \item \code{progr_comune} progressive codes of the Italian "comuni" (it restarts from 1 for each "provincia") (character);
#' \item \code{cod_provincia} codes of the Italian "province"; note that \code{cod_comune} is \code{cod_provincia} pasted to \code{progr_comune} (character);
#' \item \code{cod_citta_metro} codes of the Italian "città metropolitane" (character);
#' \item \code{cod_regione} codes of the Italian "regioni" (character);
#' \item \code{cod_rip_geo} codes of the Italian "ripartizioni geografiche" (character).
#' }
#' 
#' 
#' @source Istat website: \href{http://www.istat.it/it/archivio/6789}{Istituto nazionale di statistica (Istat)}.
NULL
##################################################################################################################################

##################################################################################################################################
#' Data on Italian Districts (Province)
#' 
#' 
#' @name province
#' 
#' 
#' @description The \code{province} dataset is related with information on the 110 Italian province and on the 9 Italian metropolitan cities
#' ("città metropolitane"), updated at 2016-01-01. 
#' 
#'  
#' @usage data(province) 
#' 
#' 
#' @format \code{province} is a tbl data frame with 110 observations on 5 variables.
#'  
#' 
#' @details 
#' The 5 variables of the \code{italia} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cod_provincia} codes of the Italian "province"; 
#' \item \code{provincia} names of the Italian "province" (character);
#' \item \code{sigla_auto} automotive initials ("targa automobilistica") of the Italian "province" (character);
#' \item \code{cod_citta_metro} codes of the Italian "città metropolitane" (character);
#' \item \code{citta_metro} names of the Italian "città metropolitane" (character);
#' }
#' 
#' 
#' @source Istat website: \href{http://www.istat.it/it/archivio/6789}{Istituto nazionale di statistica (Istat)}.
NULL
##################################################################################################################################

##################################################################################################################################
#' Data on Italian Districts (Regioni)
#' 
#' @name regioni
#' 
#' @description The \code{regioni} dataset is related with information on the 20 Italian "regioni", updated at 2016-01-01. 
#' 
#' @usage data(regioni) 
#' 
#' @format \code{regioni} is a tbl data frame with 20 observations on 2 variables.
#' 
#' @details 
#' The 2 variables of the \code{regioni} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cod_regione} codes of the Italian "regioni" (character);
#' \item \code{regione} names of the Italian "regioni" (character);
#' }
#' 
#' 
#' @source Istat website: \href{http://www.istat.it/it/archivio/6789}{Istituto nazionale di statistica (Istat)}.
NULL
##################################################################################################################################

##################################################################################################################################
#' Data on Italian Districts (Ripartizioni)
#' 
#' 
#' @name ripartizioni
#' 
#' 
#' @description The \code{ripartizioni} dataset is related with information on the 5 Italian "ripartizioni".
#'  
#' @usage data(ripartizioni) 
#' 
#' 
#' @format \code{ripartizioni} is a tbl data frame with 5 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{italia} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cod_rip_geo} codes of the Italian "ripartizioni geografiche" (character);
#' \item \code{rip_geo} names of the Italian "ripartizioni geografiche" (character).
#' }
#' 
#' 
#' @source Istat website: \href{http://www.istat.it/it/archivio/6789}{Istituto nazionale di statistica (Istat)}.
NULL
##################################################################################################################################


##################################################################################################################################
#' Fictional Data for MDS 
#' 
#' 
#' @name mds
#' 
#' 
#' @description The \code{mds} dataset is fictional and contains 10 observations on which 5 numerical variables are measured.
#' 
#'  
#' @usage data(mds)
#' 
#' 
#' @format \code{mds} is a tbl data frame with 10 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{mds} tbl data frame are the following ones:
#' \itemize{
#' \item \code{V1} (numeric);
#' \item \code{V2} (numeric);
#' \item \code{V3} (numeric);
#' \item \code{V4} (numeric);
#' \item \code{V5} (numeric);
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Motor Trend Car Road Tests 
#' 
#' 
#' @name mtcars
#' 
#' 
#' @description The \code{mtcars} data was extracted from the analogous data frame of package \code{datasets}, included in the base \code{R} distribution.
#' 
#'  
#' @usage data(mtcars)
#' 
#' 
#' @format \code{mtcars} is a tbl data frame with 32 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{mtcars} tbl data frame are the following ones:
#' \itemize{
#' \item \code{car} car model (character);
#' \item \code{carb} number of carburetors (numeric);
#' \item \code{cyl} number of cylinders (numeric);
#' \item \code{mpg} miles/(US) gallon (numeric);
#' \item \code{disp} displacement (cu.in.) (numeric).
#' }
#' 
#' 
#' @seealso the complete \code{mtcars} help page is in the \code{datasets} package: \code{\link[datasets]{mtcars}}
NULL
##################################################################################################################################


##################################################################################################################################
#' Weight and Height of 300 Italian People
#' 
#' 
#' @name people
#' 
#' 
#' @description The \code{people} dataset is related with information on 300 Italian people: their gender, area, weight and height.
#' 
#'  
#' @usage data(people)
#' 
#' 
#' @format \code{people} is a tbl data frame with 300 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{people} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Gender} gender (factor with 2 levels: Female, Male);
#' \item \code{Area} residence area (factor with 4 levels: Centro, Isole, Nord, Sud);
#' \item \code{Weight} weight in kg (numeric);
#' \item \code{Height} height in cm (numeric).
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Diabetes of Indian People 
#' 
#' 
#' @name pimaindiansdiabetes2
#' 
#' 
#' @description The \code{pimaindiansdiabetes2} data contain information about diabetes of indian people.
#' 
#'  
#' @usage data(pimaindiansdiabetes2)
#' 
#' 
#' @format \code{pimaindiansdiabetes2} is a tbl data frame with 768 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{pimaindiansdiabetes2} tbl data frame are the following ones:
#' \itemize{
#' \item \code{pregnant} Number of times pregnant (numeric);
#' \item \code{glucose} Plasma glucose concentration a 2 hours in an oral glucose tolerance test (numeric);
#' \item \code{pressure} Diastolic blood pressure (mm Hg) (numeric);
#' \item \code{triceps} Triceps skin fold thickness (mm) (numeric);
#' \item \code{insulin} 2-Hour serum insulin (mu U/ml)(numeric);
#' \item \code{mass} Body mass index (weight in kg/(height in m)^2) (numeric);
#' \item \code{pedigree} Diabetes pedigree function (numeric);
#' \item \code{age} Age (years) (numeric);
#' \item \code{diabetes} class variable: diabetic or not (factor with 2 levels: \code{neg} and \code{pos});
#' }
#' 
#' @source National Institute of Diabetes and Digestive and Kidney Diseases 
NULL
##################################################################################################################################


##################################################################################################################################
#' Prostate Cancer
#' 
#' 
#' @name prostate
#' 
#' 
#' @description The \code{prostate} data come from a study that examined the correlation between the level of prostate specific antigen and a number of clinical measures in men who were about to receive a radical prostatectomy
#' 
#'  
#' @usage data(prostate)
#' 
#' 
#' @format \code{prostate} is a tbl data frame with 97 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{prostate} tbl data frame are the following ones:
#' \itemize{
#' \item \code{lcavol} log(cancer volume) (numeric);
#' \item \code{lweight} log(prostate weight) (numeric);
#' \item \code{age} age (numeric);
#' \item \code{lbph} log(benign prostatic hyperplasia amount) (numeric);
#' \item \code{svi} seminal vesicle invasion (numeric);
#' \item \code{lcp} log(capsular penetration) (numeric);
#' \item \code{gleason} Gleason score (numeric);
#' \item \code{pgg45} percentage Gleason scores 4 or 5 (numeric);
#' \item \code{lpsa} log(prostate specific antigen) (numeric);
#' }
#' 
#' @source Stamey, T.A., Kabalin, J.N., McNeal, J.E., Johnstone, I.M., Freiha, F., Redwine, E.A. and Yang, N. (1989)
#' Prostate specific antigen in the diagnosis and treatment of adenocarcinoma of the prostate: II. radical prostatectomy treated patients, Journal of Urology 141(5), 1076–1083.
NULL
##################################################################################################################################


##################################################################################################################################
#' Sres 
#' 
#' 
#' @name sres
#' 
#' 
#' @description The \code{sres} data was .....
#' 
#'  
#' @usage data(sres)
#' 
#' 
#' @format \code{sres} is a tbl data frame with 19 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{sres} tbl data frame are the following ones:
#' \itemize{
#' \item \code{V1} (numeric);
#' \item \code{V2} (numeric);
#' \item \code{V3} (numeric).
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' 79 Companies in the U.S.
#' 
#' 
#' @name uscompanies
#' 
#' 
#' @description The \code{uscompanies} data deals with 79 U.S. companies classified by 6 numerical characteristics (assets, sales, etc.)
#' and one categorical characteristic (industry); indshort is a shortening for industry.
#' 
#'  
#' @usage data(uscompanies)
#' 
#' 
#' @format \code{uscompanies} is a tbl data frame with 79 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{uscompanies} tbl data frame are the following ones:
#' \itemize{
#' \item \code{company} car model (Factor);
#' \item \code{assets} (USD) (integer);
#' \item \code{sales} (USD) (integer);
#' \item \code{value} market value (USD) (integer);
#' \item \code{profits} (USD) (numeric);
#' \item \code{cashflow} (USD) (numeric);
#' \item \code{employees} (numeric);
#' \item \code{industry} (Factor);
#' \item \code{indshort} industry in a less fine classification (Factor);
#' }
#' 
#' 
#' @source Härdle and Simar, Applied Multivariate Statistical Analysis, 3rd ed., Springer, 2012
NULL
##################################################################################################################################


##################################################################################################################################
#' Crime Rates in the U.S.
#' 
#' 
#' @name uscrime
#' 
#' 
#' @description The \code{uscrime} data deals with crime rates (number of crimes per 100,000 residents) in the 50 U.S.;
#' the dataset includes also land and population (in 1985) of the 50 U.S., which are classified by the following seven categories:
#' murder, rape, robbery, assault, burglary, larceny and auto-theft.
#' 
#'  
#' @usage data(uscrime)
#' 
#' 
#' @format \code{uscrime} is a tbl data frame with 50 observations on 12 variables.
#' 
#' 
#' @details 
#' The 12 variables of the \code{uscrime} tbl data frame are the following ones:
#' \itemize{
#' \item \code{state} Usps states abbreviation (character);
#' \item \code{land} land area (integer);
#' \item \code{popu1985} population in 1985 (integer);
#' \item \code{murd} number of murders per 100,000 residents (numeric);
#' \item \code{rape} number of rapes per 100,000 residents (numeric);
#' \item \code{robb} number of robberies per 100,000 residents (numeric);
#' \item \code{assa} number of assaults per 100,000 residents (integer);
#' \item \code{burg} number of burglaries per 100,000 residents (integer);
#' \item \code{larc} number of larcenies per 100,000 residents (integer);
#' \item \code{auto} number of auto-thefts per 100,000 residents (integer);
#' \item \code{reg} U.S. states region number (integer);
#' \item \code{div} U.S. states division number (integer).
#' }
#' 
#' 
#' @source Härdle, W. K. and Simar, L., Applied Multivariate Statistical Analysis, 3rd edition, Springer, 2012
NULL
##################################################################################################################################


##################################################################################################################################
#' 22 Companies in the U.S.
#' 
#' 
#' @name utilities
#' 
#' 
#' @description The \code{utilities} data deals with 22 U.S. companies classified by 8 numerical characteristics (coverage, return, cost, etc.).
#' 
#'  
#' @usage data(utilities)
#' 
#' 
#' @format \code{utilities} is a tbl data frame with 22 observations on 10 variables.
#' 
#' 
#' @details 
#' The 10 variables of the \code{utilities} tbl data frame are the following ones:
#' \itemize{
#' 
#' \item \code{coverage} fixed-charge coverage ratio (income/debt) (numeric);
#' \item \code{return} rate of return on capital (numeric);
#' \item \code{cost} cost per kW capacity in place (integer);
#' \item \code{load} annual load factor (numeric);
#' \item \code{peak} peak kWh demand growth from 1974 to 1975 (numeric);
#' \item \code{sales} sales (kWh use per year) (integer);
#' \item \code{nuclear} percent nuclear (numeric);
#' \item \code{fuel} total fuel costs (cents per kWh) (numeric);
#' \item \code{company} company full name (character);
#' \item \code{comp_short} company short name (character).
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Topographic Information on Auckland's Maunga Whau Volcano
#' 
#' 
#' @name volcano3d
#' 
#' 
#' @description The \code{volcano3d} data was derived from the \code{volcano} data frame included in the base \code{R} distribution,
#' and gives the topographic information for Maunga Whau, one of about 50 volcanos in the Auckland volcanic field, on a 10m by 10m grid. 
#' 
#'  
#' @usage data(volcano3d)
#' 
#' 
#' @format \code{volcano3d} is a tbl data frame with 5307 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{volcano3d} tbl data frame are the following ones:
#' \itemize{
#' \item \code{x} x position (numeric)
#' \item \code{y} y position (numeric)
#' \item \code{z} z position (numeric)
#' }
#' 
#' 
#' @seealso the \code{volcano} help page in the \code{datasets} package: \code{\link[datasets]{volcano}}
NULL
##################################################################################################################################


##################################################################################################################################
#' Weather Daily Data in Canberra
#' 
#' 
#' @name wea
#' 
#' 
#' @description The \code{wea} data deals with weather daily data (temperature, rain, wind, etc.) in Canberra, Australia,
#' from 2007-11-01 to 2008-10-31.
#' 
#'  
#' @usage data(wea)
#' 
#' 
#' @format \code{wea} is a tbl data frame with 366 observations on 24 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{wea} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Date} (Date), format: "2007-11-01" "2007-11-02" "2007-11-03" "2007-11-04" ...
#' \item \code{Location} Factor w/ 49 levels
#' \item \code{MinTemp} (numeric)
#' \item \code{MaxTemp} (numeric)
#' \item \code{Rainfall} (numeric)
#' \item \code{Evaporation} (numeric)
#' \item \code{Sunshine} (numeric)
#' \item \code{WindGustDir} Ord.factor w/ 16 levels
#' \item \code{WindGustSpeed} (numeric)
#' \item \code{WindDir9am} Ord.factor w/ 16 levels
#' \item \code{WindDir3pm} Ord.factor w/ 16 levels
#' \item \code{WindSpeed9am} (numeric)
#' \item \code{WindSpeed3pm} (numeric)
#' \item \code{Humidity9am} (numeric)
#' \item \code{Humidity3pm} (numeric)
#' \item \code{Pressure9am} (numeric)
#' \item \code{Pressure3pm} (numeric)
#' \item \code{Cloud9am} (numeric)
#' \item \code{Cloud3pm} (numeric)
#' \item \code{Temp9am} (numeric)
#' \item \code{Temp3pm} (numeric)
#' \item \code{RainToday} Factor w/ 2 levels
#' \item \code{RISK_MM} (numeric)
#' \item \code{RainTomorrow} Factor w/ 2 levels
#' }
NULL
##################################################################################################################################


##################################################################################################################################
#' Italian Wines from Piedmont, Italy
#' 
#' 
#' @name wines
#' 
#' 
#' @description The \code{wines} data was extracted from the analogous data frame of package \code{kohonen} and contains information
#' on a set of 177 Italian wine samples from three different grape cultivars; 13 variables have been measured (alcohol, malic acid, tc.).
#' 
#'  
#' @usage data(wines)
#' 
#' 
#' @format \code{wines} is a tbl data frame with 177 observations on 13 variables.
#' 
#' 
#' @details 
#' The 13 variables of the \code{wines} tbl data frame are the following ones:
#' \itemize{
#' \item \code{alcohol} (numeric)
#' \item \code{malic.acid} (numeric)
#' \item \code{ash} (numeric)
#' \item \code{ash.alkalinity} (numeric)
#' \item \code{magnesium} (numeric)
#' \item \code{tot..phenols} (numeric)
#' \item \code{flavonoids} (numeric)
#' \item \code{non.flav..phenols} (numeric)
#' \item \code{proanth} (numeric)
#' \item \code{col..int.} (numeric)
#' \item \code{col..hue} (numeric)
#' \item \code{OD.ratio} (numeric)
#' \item \code{proline} (numeric)
#' \item \code{vintages} Factor w/ 3 levels
#' \item \code{wine.classes} (numeric)
#' }
#' 
#' 
#' @seealso the complete \code{wines} help page in the \code{kohonen} package: \code{\link[kohonen]{wines}}
NULL
##################################################################################################################################


##################################################################################################################################
#' Open era: Wimbledon tournaments
#' 
#' 
#' @name wimbledon
#' 
#' 
#' @description The \code{wimbledon} datasets contain information about the gentlemen Wimbledon finals from 1968 to 2015.
#'  
#' @usage data(wimbledon)
#' 
#' 
#' @format \code{wimbledon} is a tbl data frames with 48 observations and 10 variables.
#' 
#' 
#' @details 
#' The 10 variables of the \code{wimbledon} tbl data frame are the following ones:
#' \itemize{
#' \item \code{year} Tournament year (numeric)
#' \item \code{champion_country} champion's country (character)
#' \item \code{champion} champion's name and surname (character)
#' \item \code{runner_up_country} runner's country (character)
#' \item \code{runner_up} runner's name and surname (character)
#' \item \code{s1,s2,s3,s4,s5} scores in the five sets (character)
#' }
#' 
NULL
##################################################################################################################################

##################################################################################################################################
#' Open era: U.S. Open tournaments
#' 
#' 
#' @name usopen
#' 
#' 
#' @description The \code{usopen} datasets contain information about the gentlemen U.S. Open from 1968 to 2015.
#'  
#' @usage data(usopen)
#' 
#' 
#' @format \code{usopen} is a tbl data frames with 48 observations and 10 variables.
#' 
#' 
#' @details 
#' The 10 variables of the \code{usopen} tbl data frame are the following ones:
#' \itemize{
#' \item \code{year} Tournament year (numeric)
#' \item \code{champion_country} champion's country (character)
#' \item \code{champion} champion's name and surname (character)
#' \item \code{runner_up_country} runner's country (character)
#' \item \code{runner_up} runner's name and surname (character)
#' \item \code{s1,s2,s3,s4,s5} scores in the five sets (character)
#' }
#' 
NULL
##################################################################################################################################

##################################################################################################################################
#' Distance Matrix between 12 Country Leaders of II World War
#' 
#' 
#' @name wwiileaders
#' 
#' 
#' @description The \code{wwiileaders} data contains a distance matrix among 12 country leaders during II World War,
#' which is based on the judgments of the dissimilarities in ideology. The subjects made judgments on a nine-point scale,
#' with the extreme points of the scale, 1 and 9, being described as indicating "very similar" and "very dissimilar", respectively.
#' 
#'  
#' @usage data(wwiileaders)
#' 
#' 
#' @format \code{wwiileaders} is a distance matrix.
#' 
#' 
#' @source Everitt, B. and Hothorn, T., *An Introduction to Applied Multivariate Analysis with `R`*, Springer, 2011
NULL
##################################################################################################################################


##################################################################################################################################
#' Smoking Habits of Different Employees in a Company
#' 
#' 
#' @name smoke
#' 
#' 
#' @description The \code{smoke} dataset contain information about the smoking habits in several employees of a company. 
#' The data frame is actually a contingency table of smoking habit (None, Light, Medium, Heavy) Vs. level of employee 
#' (Senior Manager, Junior Manager, Senior Employee, Junior Employee, Secretary). Data from Greenacre (1984, p. 55)
#'  
#' @usage data(smoke)
#' 
#' 
#' @format Tbl data frame 6 observations and 4 variables with row manes.
#' 
#' 
#' @details 
#' The 4 variables are:
#' \itemize{
#' \item \code{None} Non smokers counts (numeric)
#' \item \code{Light} Light smokers counts (character)
#' \item \code{Medium} Medium smokers counts (character)
#' \item \code{Heavy} Heavy smokers counts (character)
#' }
#' 
#' @source Michael J. Greenacre, *Theory and applications of correspondence analysis*, London: Academic Press, 1984

NULL
##################################################################################################################################

##################################################################################################################################
#' Low Birthweight 
#' 
#' 
#' @name bwt
#' 
#' 
#' @description The low birthweight data contains information on low birth weight in infants born at a US hospital. 
#' A number of variables were collected that might explain the cause of the low birth weight.
#' 
#'  
#' @usage data(bwt)
#' 
#' 
#' @format \code{bwt} is a tbl data frame with 189 observations on 4 variables.
#' 
#' 
#' @details 
#' The 7 variables of the \code{bwt} tbl data frame are the following ones:
#' \itemize{
#' \item \code{low}  indicator of birth weight less than 2.5 kg. (numeric)
#' \item \code{age}  mother's age in years (numeric)
#' \item \code{lwt}  mother's weight in pounds at last menstrual period (numeric)
#' \item \code{smoke} smoking status during pregnancy (factor)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Toxoplasmosis
#' 
#' 
#' @name toxo
#' 
#' 
#' @description The low birthweight data contains information on low birth weight in infants born at a US hospital. 
#' A number of variables were collected that might explain the cause of the low birth weight.
#' 
#'  
#' @usage data(toxo)
#' 
#' 
#' @format \code{toxo} is a tbl data frame with 34 observations on 5 variables.
#' 
#' 
#' @details 
#' The 7 variables of the \code{banknotes} tbl data frame are the following ones:
#' \itemize{
#' \item \code{city}  city number (numeric)
#' \item \code{rain}  yearly rain (mm) (numeric)
#' \item \code{prop}  proportion of people affected by toxoplasmosis (numeric)
#' \item \code{num} examined people (numeric)
#' \item \code{ill} two-column matrix containing the number of non-illness (illN) and the number of illness (illY) (numeric matrix)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Measures of weigth and heigth in a sample of young people
#' 
#' 
#' @name ds
#' 
#' 
#' @description \code{ds} data contains information about weigth and height of a sample of young people. Also gender is recorded. 
#' 
#' 
#'  
#' @usage data(ds)
#' 
#' 
#' @format \code{ds} is a tbl data frame with 200 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{ds} tbl data frame are the following ones:
#' \itemize{
#' \item \code{height}  height (in cm) (numeric)
#' \item \code{weight}  weight (in Kg) (numeric)
#' \item \code{gender}  gender of a different young person (factor with levels: \code{M} and \code{F})
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Reaction temperature
#' 
#' 
#' @name reaction
#' 
#' 
#' @description A chemical theory suggests that the temperature at which a certain chemical reaction occurs is 180 °C. 
#' \code{reaction} data contains the results of 10 independent measurements of temperature. 
#' 
#' 
#'  
#' @usage data(reaction)
#' 
#' 
#' @format \code{reaction} is a vector with 10 observations.
#' 
#' 
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Growth hormones
#' 
#' 
#' @name hormones
#' 
#' 
#' @description \code{hormones} data contains the results of an experiment to compare two growth hormones. 
#' 18 chicken were tested: 10 being assigned to hormone A and 8 to hormone B. The gains in weights (grams) over the period of experiment were measured. 
#' 
#'  
#' @usage data(hormones)
#' 
#' 
#' @format \code{hormones} is a tbl data frame with 18 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{hormones} tbl data frame are the following ones:
#' \itemize{
#' \item \code{hormone} growth hormone given to chicken (factor with levels: \code{A} and \code{B})
#' \item \code{gain}  gain in weigth (grams) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Parking time
#' 
#' 
#' @name carctl
#' 
#' 
#' @description \code{carctl} data contains information of an experiment which investigates if an optional equipment of cars may help to park the cars themselves. 
#' So, 20 drivers were asked to park the car with and without the equipment. 
#' The parking time (secs) for each driver and equipment is recorded.
#'  
#'  
#' @usage data(carctl)
#' 
#' 
#' @format \code{carctl} is a tbl data frame with 20 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{carctl} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Car_a} parking time of car with equipment a (seconds) (numeric)
#' \item \code{Car_b} parking time of car with equipment b (seconds) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Car seat tissues
#' 
#' 
#' @name tissue
#' 
#' 
#' @description \code{tissue} data contains the measures of the strenght of car seat tissues made by three quality inspectors of a plant: Henry, Anne, and Andrew (operators).
#'  Each operator measured 25 pieces of car seat tissues. Globally, 75 samples of tissue randomly chosen from the same production batch were measured.
#'  
#' @usage data(tissue)
#' 
#' 
#' @format \code{tissue} is a tbl data frame with 75 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{tissue} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Operator} quality inspector name which measures the car seat tissue (factor with levels: \code{Anne}, \code{Henry} and \code{Andrew})
#' \item \code{Strength} measure of strength of the car seat tissue (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Brake distance
#' 
#' 
#' @name distance
#' 
#' 
#' @description \code{distance} data contains measurements of brake distances on the same car equipped with several configurations of tire, tread and abs.
#'  For each combination of three factor levels, 2 measurements of brake distance have been taken
#'  
#' @usage data(distance)
#' 
#' 
#' @format \code{distance} is a tbl data frame with 24 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{distance} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Tire} type of tire (factor with levels \code{GT}, \code{LS}, \code{MX})
#' \item \code{Tread} level of tread (factor with levels \code{1.5} and \code{10})
#' \item \code{ABS} indicates if abs is disabled or enabled (factor with levels with levels \code{disabled} and \code{enabled})
#' \item \code{Distance} break distance measure (in meters) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Chromosomal Abnormalities Data
#' 
#' 
#' @name dicentric
#' 
#' 
#' @description \code{dicentric} data contains numbers (\code{ca}) of chromosomal abnormalities observed for various amounts (\code{doseamt})
#' and intensities (\code{doserate}) of gamma radiation. The numbers of \code{cells} per measurement varied.
#'  
#' @usage data(dicentric)
#' 
#' 
#' @format \code{dicentric} is a tbl data frame with 27 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{dicentric} tbl data frame are the following ones:
#' \itemize{
#' \item \code{cells} Number of cells analyzed (numeric)
#' \item \code{ca}  Number of chromosomal abnormalities read (numeric)
#' \item \code{doseamt} Amount of gamma radiation (numeric)
#' \item \code{doserate} Dose rate of gamma radiation (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Pin diameters
#' 
#' 
#' @name diameters
#' 
#' 
#' @description \code{diameters} data contains data collected from five different lathes, each of these used by two different operators.
#'  
#' @usage data(diameters)
#' 
#' 
#' @format \code{diameters} is a tbl data frame with 50 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{diameters} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Lathe} lathe (factor with levels \code{1}, \code{2}, \code{3}, \code{4}, \code{5})
#' \item \code{Operator} operator (factor with levels \code{D} and \code{N})
#' \item \code{Pin.Diam} pin diameter measure (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' The Raftery and Hout Irish education data
#' 
#' 
#' @name irished
#' 
#' 
#' @description \code{irished} data contains Data on educational transitions for a sample of 500 Irish schoolchildren aged 11 in 1967.
#'  
#' @usage data(irished)
#' 
#' 
#' @format \code{irished} is a tbl data frame with 500 observations on 6 variables.
#' 
#' 
#' @details 
#' The 6 variables of the \code{irished} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Sex} Factor with levels 1 = male; 2 = female
#' \item \code{DVRT} Drumcondra Verbal Reasoning Test Score (numeric)
#' \item \code{edlevel} Educational level attained:
#'\enumerate{
#'\item Primary terminal leaver
#'\item Junior cycle incomplete: vocational school
#'\item Junior cycle incomplete: secondary school
#'\item Junior cycle terminal leaver: vocational school
#'\item Junior cycle terminal leaver: secondary school
#'\item Senior cycle incomplete: vocational school
#'\item Senior cycle incomplete: secondary school
#'\item Senior cycle terminal leaver: vocational school
#'\item Senior cycle terminal leaver: secondary school
#'\item 3rd level incomplete
#'\item 3rd level complete
#'  }
#' \item \code{lvcert} Leaving Certificate. Factor with 2 levels: 1 if Leaving Certificate not taken; 2 if taken.
#' \item \code{fathocc} Prestige score for father's occupation (calculated by Raftery and Hout, 1985) (numeric)
#' \item \code{schltype} Type of school. Factor of 3 levels: 1 = secondary; 2 = vocational; 9 = primary terminal leaver.
#' }
#' 
#' 
#' @source Data collected by Greaney and Kelleghan (1984), and reanalyzed by Raftery and Hout (1985, 1993)
NULL
##################################################################################################################################

##################################################################################################################################
#' Boiling Dataset 
#' 
#' 
#' @name boiling
#' 
#' 
#' @description In an attempt to resolve a domestic dispute about which of two pans was the quicker pan for cooking, the following data were obtained.
#' Various measured volumes (pints) of cold water were put into each pan and geated using the same setting of the cooker.
#' The response variable was the `time` in minutes until the water boiled.
#' 
#'  
#' @usage data(boiling)
#' 
#' 
#' @format \code{boiling} is a tbl data frame with 6 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{boiling} tbl data frame are the following ones:
#' \itemize{
#' \item \code{time} time to boil (minutes) (numeric);
#' \item \code{pan} type of pan (factor).
#' \item \code{volume} volume of water (pints) (numeric).
#' }
#' 
#' 
#' @seealso 
NULL
##################################################################################################################################

##################################################################################################################################
#' Reaction Times
#' 
#' 
#' @name drug
#' 
#' 
#' @description \code{drug} dataset contains the results of an experiment to investigate the effects of a depressant drug. In particular,
#'  the reaction times of ten male rats to a certain stimulus were measured after a specified dose of the drug have been administered to each rat.
#' 
#'  
#' @usage data(drug)
#' 
#' 
#' @format \code{drug} is a tbl data frame with 10 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{drug} tbl data frame are the following ones:
#' \itemize{
#' \item \code{rat} rat id (numeric);
#' \item \code{dose} specified dose of the drug administered (numeric);
#' \item \code{time} reaction time (numeric).
#' }
#' 
#' 
#'@source 
NULL
##################################################################################################################################


##################################################################################################################################
#' pH measurement tools
#' 
#' 
#' @name labonline
#' 
#' 
#' @description  Two pH measurement tools are compared: one instrument is a "gold standard", and is the "laboratory" tool, the other is an on-line (on the field) tool.
#'  Same samples are measured by using both instruments to see if on-line tool performs as laboratory tool.
#' 
#' @usage data(labonline)
#' 
#' 
#' @format \code{labonline} is a tbl data frame with 20 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{labonline} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Lab} measuments collected with the "laboratory" tool (numeric)
#' \item \code{Online} measuments collected with the on-line tool (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Polyesterification study
#' 
#' 
#' @name polyester
#' 
#' 
#' @description  In the study of the polyesterification of fatty acids with glycols, the effect of temperature (C)
#' on the percentage conversion of the esterification process was investigated. 
#' Data are the results of an experiment using a catalyst 0.0004 mole zinc chloride per 100 grams of fatty acid.
#' 
#' @usage data(polyester)
#' 
#' 
#' @format \code{polyester} is a tbl data frame with 6 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{polyester} tbl data frame are the following ones:
#' \itemize{
#' \item \code{temperature} temperature effect (numeric)
#' \item \code{conversion} percentage conversion of the esterification process (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Clotting Dataset 
#' 
#' 
#' @name clotting
#'  
#' @description From McCullagh and Nelder (1989, pp. 300-302). Hurn et al. (1945) published data on the clotting time of blood, 
#' giving clotting times in seconds (y) for normal plasma diluted to nine different percentage concentration with prothrombin-free
#' plasma (u); clotting was induce by two lots of thromboplastin. Data are analyzed using gamma errors and inverse link.
#' 
#'  
#' @usage data(clotting)
#' 
#' 
#' @format \code{clotting} is a tbl data frame with 18 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{clotting} tbl data frame are the following ones:
#' \itemize{
#' \item \code{u} percentages of diluition (numeric).
#' \item \code{y} clotting time (sec) (numeric);
#' \item \code{lot} lot of thromboplastin (factor).
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' nes96 Dataset
#' 
#' 
#' @name nes96
#'   
#' @description 10 variable subset of the 1996 American National Election Study. Missing values and "don't know" responses have been listwise deleted. Respondents expressing a voting preference other than Clinton or Dole have been removed.
#'
#'
#' @usage data(nes96)
#'  
#' @format \code{nes96} is a tbl data frame with 944 observations on 10 variables.
#'  
#' @details 
#' The 10 variables of the \code{nes96} tbl data frame are the following ones:
#' \itemize{
#' \item \code{popul} population of respondent's location in 1000s of people (numeric).
#' \item \code{TVnews} ays in the past week spent watching news on TV (numeric);
#' \item \code{selfLR} Left-Right self-placement of respondent: an ordered factor with levels extremely liberal, extLib < liberal, Lib < slightly liberal, sliLib < moderate, Mod < slightly conservative, sliCon < conservative, Con < extremely conservative, extCon (factor).
#' \item \code{ClinLR} Left-Right placement of Bill Clinton (same scale as selfLR): an ordered factor with levels extLib < Lib < sliLib < Mod < sliCon < Con < extCon (factor).
#' \item \code{DoleLR} Left-Right placement of Bob Dole (same scale as selfLR): an ordered factor with levels extLib < Lib < sliLib < Mod < sliCon < Con < extCon (factor).
#' \item \code{PID} Party identification: an ordered factor with levels strong Democrat, strDem < weak Democrat, weakDem < independent Democrat, indDem < independent independentindind < indepedent Republican, indRep < waek Republican, weakRep < strong Republican, strRep (factor).
#' \item \code{age} Respondent's age in years (numeric).
#' \item \code{educ} Respondent's education: an ordered factor with levels 8 years or less, MS < high school dropout, HSdrop < high school diploma or GED, HS < some College, Coll < Community or junior College degree, CCdeg < BA degree, BAdeg < postgraduate degree, MAdeg (factor).
#' \item \code{income} Respondent's family income: an ordered factor with levels $3Kminus < $3K-$5K < $5K-$7K < $7K-$9K < $9K-$10K < $10K-$11K < $11K-$12K < $12K-$13K < $13K-$14K < $14K-$15K < $15K-$17K < $17K-$20K < $20K-$22K < $22K-$25K < $25K-$30K < $30K-$35K < $35K-$40K < $40K-$45K < $45K-$50K < $50K-$60K < $60K-$75K < $75K-$90K < $90K-$105K < $105Kplus (factor).
#' \item \code{vote} Expected vote in 1996 presidential election: a factor with levels Clinton and Dole (factor).
#' }
#' 
#' 
#' @source Sapiro, Virginia, Steven J. Rosenstone, Donald R. Kinder, Warren E. Miller, and the National Election Studies. AMERICAN NATIONAL ELECTION STUDIES, 1992-1997: COMBINED FILE [Computer file]. 2nd ICPSR version. Ann Arbor, MI: University of Michigan, Center for Political Studies [producer], 1999. Ann Arbor, MI: Inter-university Consortium for Political and Social Research [distributor], 1999
NULL
##################################################################################################################################

##################################################################################################################################
#' Janka Hardness
#' 
#' 
#' @name janka
#' 
#' 
#' @description  Janka Hardness is an importance rating of Australian hardwood timbers. 
#' The test itself measures the force required to imbed a steel ball into a piece of wood and 
#' therefore provides a good indication to how the timber will withstand denting and wear. 
#' The dataset consists of density and hardness measurements from 36 Australian Eucalypt hardwoods.
#' 
#' @usage data(janka)
#' 
#' 
#' @format \code{janka} is a tbl data frame with 36 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{janka} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Density} density measurements (numeric)
#' \item \code{Hardness} janka hardness (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Air Pollution 
#' 
#' 
#' @name oxidant
#' 
#' 
#' @description \code{oxidant} dataset contains data on levels of an air pollutant, "Oxidant", 
#' together with levels of four meteorological variables recorded on 30 days during one summer.  
#' 
#' @usage data(oxidant)
#' 
#' 
#' @format \code{oxidant} is a tbl data frame with 30 observations on 6 variables.
#' 
#' 
#' @details 
#' The 6 variables of the \code{oxidant} tbl data frame are the following ones:
#' \itemize{
#' \item \code{day} day index (numeric)
#' \item \code{windspeed} measure of windspeed (numeric)
#' \item \code{temperature} measure of temperature (numeric)
#' \item \code{humidity} measure of humidity (numeric)
#' \item \code{insolation} measure of insolation (numeric)
#' \item \code{oxidant} measure of oxidant (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Hot Dogs 
#' 
#' 
#' @name hotdogs
#' 
#' 
#' @description \code{hotdogs} data contains calories and sodium content for three types of hot dogs: 
#' 20 Beef, 17 Meat and 17 Poultry hot dogs. This data is a sample from much larger populations.
#' 
#' @usage data(hotdogs)
#' 
#' 
#' @format \code{hotdogs} is a tbl data frame with 54 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{hotdogs} tbl data frame are the following ones:
#' \itemize{
#' \item \code{type} hotdog type (factor with levels: \code{beef}, \code{meat} and \code{poultry})
#' \item \code{calories} calories content in Kcal (numeric)
#' \item \code{sodium} sodium content (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' People Features
#' 
#' 
#' @name istat
#' 
#' 
#' @description \code{istat} data contain weight, height, gender and geographical area 
#' ("Nord", "Centro", "Sud" and "Isole") from 1806 Italian people.
#' 
#'  
#' @usage data(istat)
#' 
#' 
#' @format \code{istat} is a tbl data frame with 1806 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{istat} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Gender} gender (factor with levels: \code{Female} and \code{Male})
#' \item \code{Area} geographical area (factor with levels: \code{Nord}, \code{Centro}, \code{Sud} and \code{Isole})
#' \item \code{Weight} weight in kg (numeric)
#' \item \code{Height} height in cm (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Yield of Wheat
#' 
#' 
#' @name iowheat
#' 
#' 
#' @description \code{iowheat} dataset is a toy example that summarizes the yield of wheat (bushels per acre) 
#' for the state of Iowa between 1930-1962. In addition to yield, year, rainfall and temperature were recorded 
#' as the main predictors of yield.
#' 
#'  
#' @usage data(iowheat)
#' 
#' 
#' @format \code{iowheat} is a tbl data frame with 33 observations on 10 variables.
#' 
#' 
#' @details 
#' The 10 variables of the \code{iowheat} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Year} year of harvest (numeric)
#' \item \code{Rain0} pre-season rainfall (numeric)
#' \item \code{Temp1} mean temperature for growing month 1 (numeric)
#' \item \code{Rain1} rainfall for growing month 1 (numeric)
#' \item \code{Temp2} mean temperature for growing month 2 (numeric)
#' \item \code{Rain2} rainfall for growing month 2 (numeric)
#' \item \code{Temp3} mean temperature for growing month 3 (numeric)
#' \item \code{Rain3} rainfall for growing month 3 (numeric)
#' \item \code{Temp4} mean temperature for harvest month (numeric)
#' \item \code{Yield} yield in bushels per acre (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Mean diameter of caps produced by a forging machine
#' 
#' 
#' @name bottlecap
#' 
#' 
#' @description \code{bottlecap} dataset contains measures of the mean diameter of the caps produced by a forging machine
#' 
#'  
#' @usage data(bottlecap)
#' 
#' 
#' @format \code{bottlecap} is a tbl data frame with 840 observations on 8 variables.
#' 
#' 
#' @details 
#' The 8 variables of the \code{bottlecap} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Cavity.1} mean diameter measures of cap produced by cavity 1 (numeric)
#' \item \code{Cavity.2} mean diameter measures of cap produced by cavity 2 (numeric)
#' \item \code{Cavity.3} mean diameter measures of cap produced by cavity 3 (numeric)
#' \item \code{Cavity.4} mean diameter measures of cap produced by cavity 4 (numeric)
#' \item \code{Cavity.5} mean diameter measures of cap produced by cavity 5 (numeric)
#' \item \code{Cavity.6} mean diameter measures of cap produced by cavity 6 (numeric)
#' \item \code{Cavity.7} mean diameter measures of cap produced by cavity 7 (numeric)
#' \item \code{Cavity.8} mean diameter measures of cap produced by cavity 8 (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Filling cereal boxes
#' 
#' 
#' @name cerealbx
#' 
#' 
#' @description \code{cerealbx} dataset contains data on the filling of cereal boxes.
#' 
#'  
#' @usage data(cerealbx)
#' 
#' 
#' @format \code{cerealbx} is a tbl data frame with 6 observations on 1 variables.
#' 
#' 
#' @details 
#' The variable of the \code{cerealbx} tbl data frame is:
#' \itemize{
#' \item \code{BoxWeigh} weight of cereal boxes (g) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Comparison of two suppliers of plastics
#' 
#' 
#' @name plastic
#' 
#' 
#' @description \code{plastic} contains measurement data of resistance for wafer plastic of two suppliers.
#' 
#'  
#' @usage data(plastic)
#' 
#' 
#' @format \code{plastic} is a tbl data frame with 20 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{plastic} tbl data frame are the following ones:
#' \itemize{
#' \item \code{SupplrA} resistance of plastic wafer provided by supplier A (N) (numeric)
#' \item \code{SupplrB} resistance of plastic wafer provided by supplier B (N) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Tear resistance
#' 
#' 
#' @name sturdy
#' 
#' 
#' @description \code{sturdy} contains measurement data of tear resistance of five different raincoats brand.
#' 
#'  
#' @usage data(sturdy)
#' 
#' 
#' @format \code{sturdy} is a tbl data frame with 26 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{sturdy} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Time} time between the solicitation and the tear (minutes) (numeric)
#' \item \code{Groups} raincoats brand (factor with levels: \code{A}, \code{B}, \code{C} and \code{D})
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################


##################################################################################################################################
#' Effect of toxic agent
#' 
#' 
#' @name rats
#' 
#' 
#' @description \code{rats} contains measurement data of time survival of a sample of rats
#'  to which was administered three types of poison and four types of treatment. Each
#'  combination poison-treatment is administered to four rats.
#' 
#'  
#' @usage data(rats)
#' 
#' 
#' @format \code{rats} is a tbl data frame with 48 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{rats} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Time} survival time (hours) (numeric)
#' \item \code{Poison} poison type (factor with levels: \code{I}, \code{II} and \code{III})
#' \item \code{Treatment} type of treatment (factor with levels: \code{A}, \code{B}, \code{C} and \code{D})
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Analysis of the data of the Titanic passengers
#' 
#' 
#' @name titanic
#' 
#' 
#' @description \code{titanic} contains data concerning personal and travel informations of the single passengers, 
#' as well as their survival.
#' 
#'  
#' @usage data(titanic)
#' 
#' 
#' @format \code{titanic} is a tbl data frame with 2201 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{titanic} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Class} class of travel (factor with two levels: \code{First} and \code{Coach})
#' \item \code{Gender} gender of passengers (factor with two levels: \code{Male} and \code{Female})
#' \item \code{Age} age of passengers (numeric)
#' \item \code{Status} status of passengers (factor with two levels: \code{Died} and \code{Survived})
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Skin cancer
#' 
#' 
#' @name skin
#' 
#' 
#' @description 400 patients have been classified by cancer type and body site in which it has been detected.
#' 
#'  
#' @usage data(skin)
#' 
#' 
#' @format \code{skin} is a tbl data frame with 12 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{skin} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Counts} counts of patients (numeric)
#' \item \code{Type} cancer type (factor with four levels: \code{Melan}, \code{Super}, \code{Nodul} and \code{Indet})
#' \item \code{Site} body site of cancer (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Ozone 
#' 
#' 
#' @name ozone
#' 
#' 
#' @description \code{ozone} contains ozone data from Breiman and Friedman, 1985 
#' 
#'  
#' @usage data(ozone)
#' 
#' 
#' @format \code{ozone} is a tbl data frame with 330 observations on 9 variables.
#' 
#' 
#' @details 
#' The 9 variables of the \code{ozone} tbl data frame are the following ones:
#' \itemize{
#' \item \code{O3} Ozone conc., ppm, at Sandbug AFB. (numeric)
#' \item \code{temp} Temperature F. (max). (numeric)
#' \item \code{ibh} Inversion base height, feet (numeric)
#' \item \code{Pres} Daggett pressure gradient (mm Hg) (numeric)
#' \item \code{Vis} Visibility (miles) (numeric)
#' \item \code{Hgt} Vandenburg 500 millibar height (m) (numeric)
#' \item \code{Hum} Humidity, percent (numeric)
#' \item \code{ibt} Inversion base temperature, degrees F. (numeric)
#' \item \code{Wind} Wind speed, mph (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################
 
##################################################################################################################################
#' Quality of car seats 
#' 
#' 
#' @name carseat
#' 
#' 
#' @description \code{carseat} contains data of an experiment about the reproducibility of a measurement method aiming to test resistance of a specific material used to cover car seats.
#' As a result, an experiments involving 75 samples of material from the same batch is set up. Three operators: Kevin, Michelle and Rob are assigned to test 25 samples each.
#' 
#'  
#' @usage data(carseat)
#' 
#' 
#' @format \code{carseat} is a tbl data frame with 75 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{carseat} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Operator} operator which performed the measurement (factor with levels: \code{Michelle}, \code{Kevin} and \code{Rob})
#' \item \code{Strength} breaking load of the fabric (in kg) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Frequency Table from a Copenhagen Housing Conditions Survey 
#' 
#' 
#' @name housing
#' 
#' 
#' @description \code{housing} contains information on housing conditions in Copenhagen of 1681 householders who were surveyed on: 
#' the type of rental accommodation they occupied, the degree of contact they had with other residents, their feeling of influence on apartment management,
#' and on their level of satisfaction with their housing conditions.
#' 
#'  
#' @usage data(housing)
#' 
#' 
#' @format \code{housing} is a tbl data frame with 72 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{housing} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Sat} Satisfaction of householders with their present housing circumstances (factor with levels: \code{High}, \code{Medium} and \code{Low})
#' \item \code{Infl} Perceived degree of influence householders have on the management of the property (factor with levels: \code{High}, \code{Medium} and \code{Low})
#' \item \code{Type} Type of rental accommodation (factor with levels: \code{Tower}, \code{Atrium}, \code{Apartment} and \code{Terrace})
#' \item \code{Cont} Contact residents are afforded with other residents (factor with levels: \code{(Low} and \code{High})
#' \item \code{Freq} Frequencies: the numbers of residents in each class (numeric)
#' }
#' 
#' 
#' @source The complete \code{housing} help page is in the \code{MASS} package: \code{\link[MASS]{housing}}
NULL
##################################################################################################################################

##################################################################################################################################
#' Absenteeism from School in Rural New South Wales
#' 
#' 
#' @name quine
#' 
#' 
#' @description \code{quine} contains information about children from Walgett, New South Wales, 
#' Australia, who were classified by Culture, Age, Sex and Learner status and the number of days absent 
#' from school in a particular school year.
#' 
#'  
#' @usage data(quine)
#' 
#' 
#' @format \code{quine} is a tbl data frame with 146 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{quine} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Eth} ethnic background: Aboriginal or Not (factor with levels: \code{A} and \code{N})
#' \item \code{Sex} sex (factor with levels: \code{F} and \code{M})
#' \item \code{Age} age group (factor with levels: \code{F0}, \code{F1}, \code{F2} and \code{F3})
#' \item \code{Lrn} learner status (factor with levels: \code{(AL} (Average learner) and \code{SL} (Slow learner))
#' \item \code{Days} days absent from school in the year
#' }
#' 
#' 
#' @source he complete \code{quine} help page is in the \code{MASS} package: \code{\link[MASS]{quine}}
NULL
##################################################################################################################################

##################################################################################################################################
#' Impurities in paints
#' 
#' 
#' @name paint
#' 
#' 
#' @description \code{paint} contains the results of an experiment which has the aim to determine the relation between the rate 
#' of agitation applied to the container of paint and the number of lumps present in the containers.
#' 
#'  
#' @usage data(paint)
#' 
#' 
#' @format \code{paint} is a tbl data frame with 12 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{paint} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Stirrate} rate of agitation (revolution) applied to the container (rpm, revolutions per minute) (numeric)
#' \item \code{Impurity} number of impurities (lumps) present in the containers of paint (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Pressure Switch
#' 
#' 
#' @name switcht
#' 
#' 
#' @description \code{switcht} contains the measures of the pression (KPa) applied to 25 switches with different thickness of the membrane 
#' necessary for their open.
#' 
#'  
#' @usage data(switcht)
#' 
#' 
#' @format \code{switcht} is a tbl data frame with 25 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{switcht} tbl data frame are the following ones:
#' \itemize{
#' \item \code{DThickness} indicates the thickness of the diaphragm (mm) (numeric)
#' \item \code{SetPoint} indicates the pressure at which the switch opens (KPa) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Knocking of the engine
#' 
#' 
#' @name knock
#' 
#' 
#' @description The engeneers want to reduce the knocking of the engines. Before doing this, 
#' they have to identify which variables included in \code{knock} dataset influence this phenomenon. 
#' Data are randomly collected from 13 engines.
#' 
#'  
#' @usage data(knock)
#' 
#' 
#' @format \code{knock} is a tbl data frame with 13 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{knock} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Spark} time of advance of the spark plug ignition (numeric)
#' \item \code{AFR} air fuel ratio (Air Fuel Ratio) (numeric)
#' \item \code{Intake} inlet temperature (numeric)
#' \item \code{Exhaust} exhaust temperature (numeric)
#' \item \code{Knock} knocking of the engine (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Mortality in the most important american cities
#' 
#' 
#' @name mortality
#' 
#' 
#' @description \code{mortality} dataset contains information related to the percentage of mortality.
#' 
#'  
#' @usage data(mortality)
#' 
#' 
#' @format \code{mortality} is a tbl data frame with 60 observations on 15 variables.
#' 
#' 
#' @details 
#' The 15 variables of the \code{mortality} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Rain} annual average rainfall (numeric)
#' \item \code{JanTemp} average temperatures in January (numeric)
#' \item \code{JulyTemp} average temperatures in July (numeric)
#' \item \code{PctOver65} percentage of the population over 65 years (numeric)
#' \item \code{HHSize} average size of housing (numeric)
#' \item \code{Education} years of education (numeric)
#' \item \code{PctHomesLiveable} percentage of “habitable” homes (numeric)
#' \item \code{PopDensity} density of population (numeric)
#' \item \code{PctLowIncome} percentage of low-income families (numeric)
#' \item \code{PctWhiteCollar} percentage of employees (numeric)
#' \item \code{Hydrocarbon} pollution level by hydrocarbons (numeric)
#' \item \code{NititeOxide} pollution level of nitrite oxide (numeric)
#' \item \code{SulphurDioxide} pollution level of sulfur dioxide (numeric)
#' \item \code{RelHum} annual average relative humidity at 1 PM (numeric)
#' \item \code{MortalityRate} mortality rate for 100000 people (numeric)
#' }
#' 
#' 
#' @source Data was adapted from StatLib Website. 
NULL
##################################################################################################################################

##################################################################################################################################
#' Body weight and brain weight
#' 
#' 
#' @name brainbod
#' 
#' 
#' @description \code{brainbod} dataset contains information about the weight of body and brain of different species of animals.
#' 
#'  
#' @usage data(brainbod)
#' 
#' 
#' @format \code{brainbod} is a tbl data frame with 15 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{brainbod} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Species} animal species (character)
#' \item \code{Body} weight of the animal (in kg) (numeric)
#' \item \code{Brain} weight of the brain of the animal (in g) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Students awards number
#' 
#' 
#' @name awards
#' 
#' 
#' @description \code{awards} dataset contains information about the number of awards earned by students at one high school, 
#' the type of program in which the student was enrolled (e.g., vocational, general or academic) and the score on their final exam in math.
#' 
#'  
#' @usage data(awards)
#' 
#' 
#' @format \code{awards} is a tbl data frame with 200 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{awards} tbl data frame are the following ones:
#' \itemize{
#' \item \code{id} students id (factor)
#' \item \code{num_awrds} number of awards earned by students at a high school in a year (numeric)
#' \item \code{prog} students' scores on their math final exam (numeric)
#' \item \code{math}  type of program in which the students were enrolled (factor with levels: \code{(1} (General), \code{(2} (Academic) and \code{3} (Vocational))
#' }
#' 
#' 
#' @source \url{http://www.ats.ucla.edu/stat/r/dae/poissonreg.htm}
NULL
##################################################################################################################################

##################################################################################################################################
#' Graduate school admission
#' 
#' 
#' @name admission
#' 
#' 
#' @description \code{admission} dataset contains information about how GRE (Graduate Record Exam scores), 
#' GPA (grade point average) and prestige of the undergraduate institution, affect admission into graduate school.
#'  
#' @usage data(admission)
#' 
#' 
#' @format \code{admission} is a tbl data frame with 400 observations on 4 variables.
#' 
#' 
#' @details 
#' The 4 variables of the \code{admission} tbl data frame are the following ones:
#' \itemize{
#' \item \code{admit} admission into graduate school (binary variable: \code{0} (Not admitted) and \code{1} (Admitted))
#' \item \code{gre} GRE (Graduate Record Exam scores) (numeric)
#' \item \code{gpa} GPA (grade point average)  (numeric)
#' \item \code{rank} prestige of the undergraduate institution (factor with levels: \code{(1} (highest prestige), \code{(2}, \code{3} and \code{4} (lowest prestige))
#' }
#' 
#' 
#' @source \url{http://www.ats.ucla.edu/stat/r/dae/logit.htm}
NULL
##################################################################################################################################

##################################################################################################################################
#' Multi-head machine
#' 
#' 
#' @name pencap
#' 
#' 
#' @description \code{pencap} dataset contains information about the width of caps for pens produced by 16 different heads.
#'  
#' @usage data(pencap)
#' 
#' 
#' @format \code{pencap} is a tbl data frame with 320 observations on 2 variables.
#' 
#' 
#' @details 
#' The 2 variables of the \code{pencap} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Cavity} number of head (factor)
#' \item \code{Width} measurement (in mm) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Solvent for varnish
#' 
#' 
#' @name varnish
#' 
#' 
#' @description \code{varnish} dataset contains information about an experiment to evaluate the efficacy of a solvent to dissolve stains of nail
#' varnish from fabrics. The experiment consists in immersing 5 stained fabrics by a certain type of varnish into a bowl with a
#'  solvent, measuring the time (in minutes) necessary to dissolve the stain.
#'  
#' @usage data(varnish)
#' 
#' 
#' @format \code{varnish} is a tbl data frame with 30 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{varnish} tbl data frame are the following ones:
#' \itemize{
#' \item \code{Solvent} type of solvent (factor with levels: \code{1} and \code{2})
#' \item \code{Varnish} type of varnish (factor with levels: \code{1}, \code{2} and \code{3})
#'  \item \code{Time} time necessary to dissolve the stain (minutes) (numeric)
#' }
#' 
#' 
#' @source 
NULL
##################################################################################################################################

##################################################################################################################################
#' Longitude and Latitude about italian cities
#' 
#' 
#' @name italy
#' 
#' 
#' @description \code{italy} dataset contains information about latitude, longitude, population and region of the most important italian cities. 
#'  
#' @usage data(italy)
#' 
#' 
#' @format \code{italy} is a tbl data frame with 56 observations on 5 variables.
#' 
#' 
#' @details 
#' The 5 variables of the \code{italy} tbl data frame are the following ones:
#' \itemize{
#'  \item \code{city} city name (character)
#'  \item \code{lat} latitude (numeric)
#'  \item \code{lon} longitude (numeric)
#'  \item \code{pop} population (numeric)
#'  \item \code{region} region (character)
#' }
#' 
#' 
#' @source \url{http://simplemaps.com/resources/world-cities-data}
NULL
##################################################################################################################################

##################################################################################################################################
#' NCCTG Lung Cancer Data
#' 
#' 
#' @name lung
#' 
#' 
#' @description \code{lung} dataset contains information about survival in patients with advanced lung cancer from the North Central Cancer Treatment Group. 
#' Performance scores rate how well the patient can perform usual daily activities.
#' 
#' @usage data(lung)
#' 
#' 
#' @format \code{lung} is a tbl data frame with 228 observations on 10 variables.
#' 
#' 
#' @details 
#' The 10 variables of the \code{lung} tbl data frame are the following ones:
#' \itemize{
#'  \item \code{inst} Institution code (numeric)
#'  \item \code{time} Survival time in days (numeric)
#'  \item \code{status} censoring status 1=censored, 2=dead (numeric)
#'  \item \code{age} Age in years (numeric)
#'  \item \code{sex} Male=1 Female=2 (numeric)
#'  \item \code{ph.ecog} ECOG performance score 0=good 5=dead) (numeric)
#'  \item \code{ph.karno} Karnofsky performance score rated by physician (numeric)
#'  \item \code{pat.karno} Karnofsky performance score (bad=0-good=100) as rated by patient (numeric)
#'  \item \code{meal.cal} Calories consumed at meals (numeric)
#'  \item \code{wt.loss} Weight loss in last six months (numeric)
#' }
#' 
#' 
#' @source The complete \code{lung} help page is in the \code{Survival} package: \code{\link[Survival]{lung}}
NULL
##################################################################################################################################

##################################################################################################################################
#' Growth of Orange Trees
#' 
#' 
#' @name orange
#' 
#' 
#' @description \code{orange} dataset contains information information about the growth of 5 Orange Trees, 
#' according to their trunk circumferences.
#' 
#' @usage data(orange)
#' 
#' 
#' @format \code{orange} is a tbl data frame with 35 observations on 3 variables.
#' 
#' 
#' @details 
#' The 3 variables of the \code{orange} tbl data frame are the following ones:
#' \itemize{
#'  \item \code{Tree} tree id (character)
#'  \item \code{age} age of the tree (numeric)
#'  \item \code{circumference} trunk circumferences (mm) (numeric)
#' }
#' 
#' 
#' @source The original \code{Orange} dataset is included in \code{Datasets} package.
NULL
##################################################################################################################################
