# # Make sure to install all dependencies (not needed if already done):
# install.packages("SqlRender")
# install.packages("DatabaseConnector")
# install.packages("ggplot2")
# install.packages("ParallelLogger")
# install.packages("readr")
# install.packages("tibble")
# install.packages("dplyr")
# install.packages("RJSONIO")
# install.packages("devtools")
# devtools::install_github("FeatureExtraction")
# devtools::install_github("ROhdsiWebApi")
# devtools::install_github("CohortDiagnostics")

# Load the package
library(InfluenzaHospCohortDiag)

# Optional: specify where the temporary files (used by the ff package) will be created:
options(fftempdir = "C:/FFtemp")

# Maximum number of cores to be used:
maxCores <- parallel::detectCores()

# Details for connecting to the server:
# connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = "pdw",
#                                                                 server = Sys.getenv("PDW_SERVER"),
#                                                                 user = NULL,
#                                                                 password = NULL,
#                                                                 port = Sys.getenv("PDW_PORT"))

# For Oracle: define a schema that can be used to emulate temp tables:
# oracleTempSchema <- NULL

# Details specific to the database:
# outputFolder <- "s:/InfluenzaHospCohortDiag/mdcd"
# cdmDatabaseSchema <- "cdm_ibm_mdcd_v1023.dbo"
# cohortDatabaseSchema <- "scratch.dbo"
# cohortTable <- "mschuemi_skeleton_mdcd"
# databaseId <- "MDCD"
# databaseName <- "Truven Health MarketScan® Multi-State Medicaid Database"
# databaseDescription <- "Truven Health MarketScan® Multi-State Medicaid Database (MDCD) adjudicated US health insurance claims for Medicaid enrollees from multiple states and includes hospital discharge diagnoses, outpatient diagnoses and procedures, and outpatient pharmacy claims as well as ethnicity and Medicare eligibility. Members maintain their same identifier even if they leave the system for a brief period however the dataset lacks lab data. [For further information link to RWE site for Truven MDCD."

# Use this to run the cohorttDiagnostics. The results will be stored in the diagnosticsExport subfolder of the outputFolder. This can be shared between sites.
runCohortDiagnostics(connectionDetails = connectionDetails,
                     cdmDatabaseSchema = cdmDatabaseSchema,
                     cohortDatabaseSchema = cohortDatabaseSchema,
                     cohortTable = cohortTable,
                     oracleTempSchema = oracleTempSchema,
                     outputFolder = outputFolder,
                     databaseId = databaseId,
                     databaseName = databaseName,
                     databaseDescription = databaseDescription,
                     createCohorts = TRUE,
                     runInclusionStatistics = TRUE,
                     runIncludedSourceConcepts = TRUE,
                     runOrphanConcepts = FALSE,
                     runTimeDistributions = TRUE,
                     runBreakdownIndexEvents = TRUE,
                     runIncidenceRates = TRUE,
                     runCohortOverlap = TRUE,
                     runCohortCharacterization = TRUE,
                     minCellCount = 10)

# To view your results: 
CohortDiagnostics::launchDiagnosticsExplorer(file.path(outputFolder, "diagnosticsExport"))


##Create Table 1
tableSpecification <- setTableSpecification(useDemographicsGender = T,
                                            useDemographicsAge = T,
                                            useDemographicsAgeGroup = T,
                                            useDemographicsRace = T,
                                            useDemographicsEthnicity = FALSE,
                                            useDemographicsIndexYear = FALSE,
                                            useDemographicsIndexMonth = T,
                                            useDemographicsPriorObservationTime = FALSE,
                                            useDemographicsPostObservationTime = FALSE,
                                            useDemographicsTimeInCohort = FALSE,
                                            useDemographicsIndexYearMonth = T,
                                            conceptIdsConditionOccurrenceAnyTimePrior = c(),
                                            conceptIdsConditionOccurrenceLongTerm = c(4006969,438409,4212540,255573,201606,4182210,440383,201820,318800,192671,439727,432867,316866,4104000,433736,80180,255848,140168,4030518,80809,435783,4279309,81893,81902,197494,4134440),
                                            conceptIdsConditionOccurrenceMediumTerm = c(),
                                            conceptIdsConditionOccurrenceShortTerm = c(),
                                            conceptIdsConditionOccurrencePrimaryInpatientAnyTimePrior = c(),
                                            conceptIdsConditionOccurrencePrimaryInpatientLongTerm = c(),
                                            conceptIdsConditionOccurrencePrimaryInpatientMediumTerm = c(),
                                            conceptIdsConditionOccurrencePrimaryInpatientShortTerm = c(),
                                            conceptIdsConditionEraAnyTimePrior = c(),
                                            conceptIdsConditionEraLongTerm = c(),
                                            conceptIdsConditionEraMediumTerm = c(),
                                            conceptIdsConditionEraShortTerm = c(),
                                            conceptIdsConditionEraOverlapping = c(),
                                            conceptIdsConditionEraStartLongTerm = c(),
                                            conceptIdsConditionEraStartMediumTerm = c(),
                                            conceptIdsConditionEraStartShortTerm = c(),
                                            conceptIdsConditionGroupEraAnyTimePrior = c(),
                                            conceptIdsConditionGroupEraLongTerm = c(),
                                            conceptIdsConditionGroupEraMediumTerm = c(),
                                            conceptIdsConditionGroupEraShortTerm = c(),
                                            conceptIdsConditionGroupEraOverlapping = c(),
                                            conceptIdsConditionGroupEraStartLongTerm = c(),
                                            conceptIdsConditionGroupEraStartMediumTerm = c(),
                                            conceptIdsConditionGroupEraStartShortTerm = c(),
                                            conceptIdsDrugExposureAnyTimePrior = c(),
                                            conceptIdsDrugExposureLongTerm = c(),
                                            conceptIdsDrugExposureMediumTerm = c(),
                                            conceptIdsDrugExposureShortTerm = c(),
                                            conceptIdsDrugEraAnyTimePrior = c(),
                                            conceptIdsDrugEraLongTerm = c(),
                                            conceptIdsDrugEraMediumTerm = c(),
                                            conceptIdsDrugEraShortTerm = c(),
                                            conceptIdsDrugEraOverlapping = c(),
                                            conceptIdsDrugEraStartLongTerm = c(),
                                            conceptIdsDrugEraStartMediumTerm = c(),
                                            conceptIdsDrugEraStartShortTerm = c(),
                                            conceptIdsDrugGroupEraAnyTimePrior = c(),
                                            conceptIdsDrugGroupEraLongTerm = c(21601782, 21602796),
                                            conceptIdsDrugGroupEraMediumTerm = c(),
                                            conceptIdsDrugGroupEraShortTerm = c(),
                                            conceptIdsDrugGroupEraOverlapping = c(),
                                            conceptIdsDrugGroupEraStartLongTerm = c(),
                                            conceptIdsDrugGroupEraStartMediumTerm = c(),
                                            conceptIdsDrugGroupEraStartShortTerm = c(),
                                            conceptIdsProcedureOccurrenceAnyTimePrior = c(),
                                            conceptIdsProcedureOccurrenceLongTerm = c(),
                                            conceptIdsProcedureOccurrenceMediumTerm = c(),
                                            conceptIdsProcedureOccurrenceShortTerm = c(),
                                            conceptIdsDeviceExposureAnyTimePrior = c(),
                                            conceptIdsDeviceExposureLongTerm = c(),
                                            conceptIdsDeviceExposureMediumTerm = c(),
                                            conceptIdsDeviceExposureShortTerm = c(),
                                            conceptIdsMeasurementAnyTimePrior = c(),
                                            conceptIdsMeasurementLongTerm = c(),
                                            conceptIdsMeasurementMediumTerm = c(),
                                            conceptIdsMeasurementShortTerm = c(),
                                            conceptIdsMeasurementValueAnyTimePrior = c(),
                                            conceptIdsMeasurementValueLongTerm = c(),
                                            conceptIdsMeasurementValueMediumTerm = c(),
                                            conceptIdsMeasurementValueShortTerm = c(),
                                            conceptIdsMeasurementRangeGroupAnyTimePrior = c(),
                                            conceptIdsMeasurementRangeGroupLongTerm = c(),
                                            conceptIdsMeasurementRangeGroupMediumTerm = c(),
                                            conceptIdsMeasurementRangeGroupShortTerm = c(),
                                            conceptIdsObservationAnyTimePrior = c(),
                                            conceptIdsObservationLongTerm = c(),
                                            conceptIdsObservationMediumTerm = c(),
                                            conceptIdsObservationShortTerm = c(),
                                            useCharlsonIndex = T,
                                            useDcsi = FALSE,
                                            useChads2 = FALSE,
                                            useChads2Vasc = FALSE,
                                            useHfrs = F,#T,
                                            useDistinctConditionCountLongTerm = FALSE,
                                            useDistinctConditionCountMediumTerm = FALSE,
                                            useDistinctConditionCountShortTerm = FALSE,
                                            useDistinctIngredientCountLongTerm = FALSE,
                                            useDistinctIngredientCountMediumTerm = FALSE,
                                            useDistinctIngredientCountShortTerm = FALSE,
                                            useDistinctProcedureCountLongTerm = FALSE,
                                            useDistinctProcedureCountMediumTerm = FALSE,
                                            useDistinctProcedureCountShortTerm = FALSE,
                                            useDistinctMeasurementCountLongTerm = FALSE,
                                            useDistinctMeasurementCountMediumTerm = FALSE,
                                            useDistinctMeasurementCountShortTerm = FALSE,
                                            useDistinctObservationCountLongTerm = FALSE,
                                            useDistinctObservationCountMediumTerm = FALSE,
                                            useDistinctObservationCountShortTerm = FALSE,
                                            useVisitCountLongTerm = FALSE,
                                            useVisitCountMediumTerm = FALSE,
                                            useVisitCountShortTerm = FALSE,
                                            useVisitConceptCountLongTerm = FALSE,
                                            useVisitConceptCountMediumTerm = FALSE,
                                            useVisitConceptCountShortTerm = FALSE,
                                            longTermStartDays = -365,
                                            mediumTermStartDays = -180,
                                            shortTermStartDays = -30,
                                            endDays = -1) #you can try diverse time settings

table1 <- comparativeCharacterization(connectionDetails = connectionDetails,
                                      cdmDatabaseSchema = cdmDatabaseSchema,
                                      cohortDatabaseSchema = cohortDatabaseSchema,
                                      cohortTable = cohortTable,
                                      oracleTempSchema = oracleTempSchema,
                                      outputFolder = outputFolder,
                                      minCellCount = 1,
                                      targetCohortId = 5,
                                      comparatorCohortId = 7,
                                      outcomeCohortIds = NULL,
                                      tableSpecification = tableSpecification,
                                      sampleSize = NULL,
                                      output = "one column",
                                      percentDigits = 1, 
                                      valueDigits = 1,
                                      stdDiffDigits = 2,
                                      studyPopulationSetting = NULL)


