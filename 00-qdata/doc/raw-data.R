####################################################################################################
##### Script for modifying raw data and save them in the data directory of the package
####################################################################################################

rm(list = ls())

### Packages
require(dplyr)
require(readxl)
require(reshape2)
require(kohonen)
require(lubridate)
require(MSQC)
## ATTENTION: other packages you need to install: kohonen, MSQC


############################################################
##### BANDS
############################################################

### Import data
bands <- read.table(file = "./rowdata/bands/bands.data.txt", sep =",", header = FALSE, na.strings = "?") %>% tbl_df

### Column names
names(bands) <- c(
  "timestamp", "cylinder_number", "customer", "job_number", "grain_screened",
  "ink_color", "proof_on_ctd_ink", "blade_mfg", "cylinder_division", "paper_type", 
  "ink_type", "direct_steam", "solvent_type", "type_on_cylinder", "press_type", 
  "press", "unit_number", "cylinder_size", "paper_mill_location", "plating_tank", 
  "proof_cut", "viscosity", "caliper", "ink_temperature", "humidity", "roughness", 
  "blade_pressure", "varnish_pct", "press_speed", "ink_pct", "solvent_pct", 
  "esa_voltage", "esa_amperage", "wax", "hardener", "roller_durometer", "current_density", 
  "anode_space_ratio", "chrome_content", "band_type"
)

### Variables codings
bands <- bands %>% mutate(
  cylinder_number = toupper(cylinder_number),
  customer = toupper(customer),
  grain_screened = as.factor(toupper(grain_screened)),
  ink_color = as.factor(toupper(ink_color)),
  proof_on_ctd_ink = as.factor(toupper(proof_on_ctd_ink)),
  blade_mfg = as.factor(toupper(blade_mfg)),
  cylinder_division = as.factor(toupper(cylinder_division)),
  paper_type = as.factor(toupper(paper_type)),
  ink_type = as.factor(toupper(ink_type)),
  direct_steam = as.factor(toupper(direct_steam)),
  solvent_type = as.factor(toupper(solvent_type)),
  type_on_cylinder = as.factor(toupper(type_on_cylinder)),
  press_type = as.factor(toupper(press_type)),
  cylinder_size = as.factor(toupper(cylinder_size)),
  paper_mill_location = as.factor(toupper(paper_mill_location)),
  band_type = as.factor(toupper(band_type))
)

### Save data frames
save(bands, file = "./data/bands.RData", compress = TRUE)



############################################################
##### BANK
############################################################
require(lubridate)
### Import data
bank <- read.table(file = "./rowdata/bank/bank-modified.csv", sep ="|", header = TRUE)

### New variables

Sys.setlocale("LC_TIME", "en_US.UTF-8")
bank <- bank %>% mutate(date = ymd(paste(year, month, day, sep = "-"))) %>%
                 mutate(month = factor(month, levels = c("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"))) %>%  
                dplyr::select (id, age,job,marital,education,default,balance,housing,loan,contact,day,month,year, date, duration, campaign, pdays, previous, poutcome,  y)


### Two variables subsets
bank1 <- bank %>% dplyr::select(id:contact, duration)
bank2 <- bank %>% dplyr::select(id, day:y)

set.seed(123)
bank1 <- bank1 %>% sample_frac
bank2 <- bank2 %>% sample_frac

### Save data frames
save(bank, bank1, bank2, file = "./data/bank.RData", compress = TRUE)



############################################################
##### BANKNOTES
############################################################

### Import data
load("./rowdata/banknotes/banknotes.RData")
banknotes <- banknotes %>% tbl_df

### Save data frames
save(banknotes, file = "data/banknotes.RData", compress = TRUE)



############################################################
##### BIMETAL1
############################################################
### Import data
data(bimetal1, package = "MSQC")
bimetal1 <- bimetal1 %>% data.frame %>% tbl_df

### Save data frames
save(bimetal1, file = "data/bimetal1.RData", compress = TRUE)



############################################################
##### BOSTONHOUSING
############################################################

### Import data
load("./rowdata/bostonhousing/bostonhousing.RData")
bostonhousing <- BostonHousing %>% tbl_df; rm(BostonHousing)

### Save data frames
save(bostonhousing, file = "data/bostonhousing.RData", compress = TRUE)



############################################################
##### DEFAULT
############################################################

### Import data
default <- read_excel(path = "./rowdata/default/default of credit card clients.xls", skip = 1)

### Save data frames
save(default, file = "data/default.RData", compress = TRUE)



############################################################
##### DIABETES 
############################################################

# Set base path to directory containing raw data
path <- "./rowdata/diabetes"

# List all files with data in the directory
list_files <- list.files(file.path(path), pattern="data-")

# Initialize output data frame
dfr <- data.frame()

# Read each file and add to output data frame
for (index in list_files) {
  print(substr(index, 6, 7))
  ds <- read.table(file.path(path, index))
  ds$patient <- substr(index, 6, 7)
  dfr <- rbind(dfr, ds)
}

# Change column order
dfr <- dfr[, c(5,1:4)]

# Names variable
names(dfr) <- c("patient", "date", "time", "code", "value")

# Assign tbl class
diabetes <- dplyr::tbl_df(dfr)

### Save data frames
save(diabetes, file = "data/diabetes.RData", compress = TRUE)



############################################################
##### DRUGUSE
############################################################

### Import data
load("./rowdata/druguse/druguse.RData")

### Save data frames
save(druguse, file = "data/druguse.RData", compress = TRUE)



############################################################
##### FORBES94
############################################################

### Import data
load("./rowdata/forbes94/forbes94.RData")
forbes94 <- forbes94 %>% tbl_df

### Save data frames
save(forbes94, file = "data/forbes94.RData", compress = TRUE)



############################################################
##### G1RES
############################################################

### Import data
g1res <- read.table(file = "./rowdata/g1res/g1res.csv", sep = ";", dec = ",")
g1res <- g1res %>% tbl_df

### Save data frames
save(g1res, file = "data/g1res.RData", compress = TRUE)



############################################################
##### GERMAN
############################################################

### Import data
## Complete data
load("./rowdata/german/german.RData")
german <- GermanCredit %>% tbl_df; rm(GermanCredit)
## String format
germanstring <- read.table(file = "./rowdata/german/german-string.csv")
germanstring <- germanstring %>% tbl_df
## Numeric format
germannumeric <- read.table(file = "./rowdata/german/german-numeric.csv")
germannumeric <- germannumeric %>% tbl_df

### Save data frames
save(german, germanstring, germannumeric, file = "data/german.RData", compress = TRUE)



############################################################
##### ITALIA
############################################################
rm(list = ls())
### Import data
ds <- read.table("./rowdata/italia/codstat-1.csv", sep = ";", head = F , stringsAsFactors = FALSE, skip = 1, quote = "\"")

### Remove rows with all NA's
ds <- ds %>% mutate(na = apply(X = ds, MARGIN = 1, FUN = function(x) all(is.na(x))))
ds <- ds %>% filter(!na) %>% select(-na)

### Rename columns and keep only interesting columns
colnames(ds)[1:19] <- c("cod_regione","cod_citta_metro","cod_provincia","progr_comune","cod_comune",
                        "comune","comune_ted","cod_rip_geo","rip_geo","regione","citta_metro","provincia",
                        "comune_cap_prov","sigla_auto","cod_comune_num","cod_comune_num_1","cod_comune_num_2",
                        "cod_catastale_comune","pop_legale")
vars <- colnames(ds)[c(1:6,8:15,19)]
ds <- ds %>% dplyr::select(one_of(vars))

### Columns topic
vars_df <- data.frame(var = vars,
                      comune = c(TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,
                                 FALSE,FALSE,FALSE,TRUE,FALSE,TRUE,TRUE),
                      provincia = c(FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,
                                    FALSE,TRUE,TRUE,FALSE,TRUE,FALSE,FALSE),
                      regione = c(TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
                                  TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE),
                      ripartizione = c(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,
                                       FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE),
                      stringsAsFactors = FALSE)

### Reorder columns
var_pos <- c(5,6,12,15,4,3,11,13,2,10,1,9,7,8)
vars_df <- vars_df %>% slice(var_pos)

### Create data frames
## Italia
italia <- ds[,var_pos] %>% tbl_df; rm(ds)
italia$provincia[italia$provincia == "-"] <- italia$citta_metro[italia$provincia == "-"]
italia$comune_cap_prov <- as.logical(italia$comune_cap_prov)
italia$pop_legale <- as.integer(italia$pop_legale)
italia$cod_rip_geo <- as.character(italia$cod_rip_geo)
## Comuni
comuni <- italia %>% dplyr::select(one_of(vars_df$var[vars_df$comune]))
## Province
province <- italia %>% dplyr::select(one_of(vars_df$var[vars_df$provincia])) %>% unique %>% tbl_df
## Regioni
regioni <- italia %>% dplyr::select(one_of(vars_df$var[vars_df$regione])) %>% unique %>% tbl_df
## Ripartizioni geografiche
ripartizioni <- italia %>% dplyr::select(one_of(vars_df$var[vars_df$ripartizione])) %>% unique %>% tbl_df

### Save data frames
save(italia, comuni, province, regioni, ripartizioni, file = "data/italia.RData", compress = TRUE)



############################################################
##### LIFE
############################################################

### Import data
load("./rowdata/life/life.RData")
life <- life %>% add_rownames(var = "country") %>% tbl_df

### Save data frames
save(life, file = "data/life.RData", compress = TRUE)



############################################################
##### MDS
############################################################

### Import data
load("./rowdata/mds/mds.RData")
mds <- X %>% tbl_df; rm(X)

### Save data frames
save(mds, file = "data/mds.RData", compress = TRUE)



############################################################
##### MTCARS
############################################################

### Prepare mtcars data
rm(list = ls())
mtcars <-
  mtcars %>%
  add_rownames(var = "car") %>%  
  dplyr::select(car, carb, cyl, mpg, disp) %>% 
  dplyr::arrange(carb, cyl, mpg, disp)

### Save data frames
save(mtcars, file = "data/mtcars.RData", compress = TRUE)



############################################################
##### PEOPLE
############################################################

### Import data
load("./rowdata/people/people.RData")
people <- istat %>% tbl_df; rm(istat)

### Save data frames
save(people, file = "data/people.RData", compress = TRUE)



############################################################
##### PIMAINDIANSDIABETES2
############################################################

### Import data
load("./rowdata/pimaindiansdiabetes2/pimaindiansdiabetes2.RData")
pimaindiansdiabetes2 <- PimaIndiansDiabetes2 %>% tbl_df; rm(PimaIndiansDiabetes2)

### Save data frames
save(pimaindiansdiabetes2, file = "data/pimaindiansdiabetes2.RData", compress = TRUE)



############################################################
##### PROSTATE
############################################################

### Import data
load("./rowdata/prostate/prostate.RData")
prostate <- Prostate %>% tbl_df; rm(Prostate)

### Save data frames
save(prostate, file = "data/prostate.RData", compress = TRUE)


############################################################
##### SMOKE
############################################################

### Import data
load("./rowdata/smoke/smoke.RData")
smoke <- smoke %>% tbl_df

### Save data frames
save(banknotes, file = "data/smoke.RData", compress = TRUE)


############################################################
##### SRES
############################################################

### Import data
sres <- read.table(file = "./rowdata/sres/sres.csv", sep = ";", dec = ",")
sres <- sres %>% tbl_df

### Save data frames
save(sres, file = "data/sres.RData", compress = TRUE)



############################################################
##### TENNIS
############################################################

### Import data
wimbledon <- read.table("./rowdata/tennis/wimbledon.txt", sep = ",", header = TRUE, stringsAsFactors = FALSE)
usopen <- read.table("./rowdata/tennis/usopen.txt", sep = ",", header = TRUE, stringsAsFactors = FALSE)
wimbledon <- wimbledon %>% tbl_df
usopen <- usopen %>% tbl_df

### Save data frames
save(usopen, wimbledon, file = "data/tennis.RData", compress = TRUE)



############################################################
##### USCOMPANIES
############################################################

### Import data
load("./rowdata/uscompanies/uscompanies.RData")
uscompanies <- uscomp %>% tbl_df; rm(uscomp)

### Save data frames
save(uscompanies, file = "data/uscompanies.RData", compress = TRUE)



############################################################
##### USCRIME
############################################################

### Import data
load("./rowdata/uscrime/uscrime.RData")
uscrime <- crime %>% add_rownames(var = "state") %>% tbl_df; rm(crime)

### Save data frames
save(uscrime, file = "data/uscrime.RData", compress = TRUE)



############################################################
##### UTILITIES
############################################################

### Import data
load("./rowdata/utilities/utilities.RData")
utilities <- utilities %>% tbl_df

### Save data frames
save(utilities, file = "data/utilities.RData", compress = TRUE)



############################################################
##### VOLCANO3D
############################################################

### Import data
volcano3d <- volcano %>% melt %>% tbl_df
colnames(volcano3d) <- c("x","y","z")

### Save data frames
save(volcano3d, file = "data/volcano3d.RData", compress = TRUE)



############################################################
##### WEA
############################################################

### Import data
load("./rowdata/wea/wea.RData")
wea <- wea %>% tbl_df

### Save data frames
save(wea, file = "data/wea.RData", compress = TRUE)



############################################################
##### WINES
############################################################

### Import data
data(wines, package = "kohonen")
wines <-
  wines %>% data.frame %>% tbl_df %>%
  mutate(vintages = vintages, wine.classes = wine.classes)

### Save data frames
save(wines, file = "data/wines.RData", compress = TRUE)



############################################################
##### WWIILEADERS
############################################################

### Import data
load("./rowdata/wwiileaders/wwiileaders.RData")
wwiileaders <- WWIIleaders; rm(WWIIleaders)

### Save data frames
save(wwiileaders, file = "data/wwiileaders.RData", compress = TRUE)

