# Copyright 2020 Observational Health Data Sciences and Informatics
#
# This file is part of InfluenzaHospCohortDiag
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Comparative Characterization
#'
#' @details
#' This function create the comparative table 1 for target and comparator
#'
#' @export
comparativeCharacterization <- function(connectionDetails,
                                        cdmDatabaseSchema,
                                        cohortDatabaseSchema = cdmDatabaseSchema,
                                        cohortTable = "cohort",
                                        oracleTempSchema = NULL,
                                        outputFolder,
                                        minCellCount = 0,
                                        targetCohortId,
                                        comparatorCohortId = NULL,
                                        outcomeCohortIds = NULL,
                                        tableSpecification = setTableSpecification(),
                                        sampleSize = NULL,
                                        output = "one column",
                                        percentDigits = 1, 
                                        valueDigits = 1,
                                        stdDiffDigits = 2,
                                        studyPopulationSetting = NULL,
                                        fileName = NULL){
  if (!file.exists(outputFolder))
    dir.create(outputFolder, recursive = TRUE)
  if (!is.null(getOption("fftempdir")) && !file.exists(getOption("fftempdir"))) {
    warning("fftempdir '", getOption("fftempdir"), "' not found. Attempting to create folder")
    dir.create(getOption("fftempdir"), recursive = TRUE)
  }
  
  ParallelLogger::addDefaultFileLogger(file.path(outputFolder, "log.txt"))
  
  if(is.null(outcomeCohortIds)){
    exportFolder <- file.path(outputFolder, "export", "table1")
    if (!file.exists(exportFolder)) {
      dir.create(exportFolder, recursive = TRUE)
    }
    
    targetCovData <- FeatureExtraction::getDbCovariateData(connectionDetails = connectionDetails,
                                                           cdmDatabaseSchema = cdmDatabaseSchema,
                                                           cohortDatabaseSchema = cohortDatabaseSchema,
                                                           cohortTable = cohortTable,
                                                           cohortId = targetCohortId,
                                                           rowIdField = "subject_id",
                                                           covariateSettings = tableSpecification$covariateSetting,
                                                           aggregated = F)
    targetCovAggData <- FeatureExtraction::aggregateCovariates(targetCovData)
    ParallelLogger::logInfo(sprintf("Covariates for target Id %s are extracted", targetCohortId))
    
    if(!is.null(comparatorCohortId)){
      comparatorCovData <- FeatureExtraction::getDbCovariateData(connectionDetails = connectionDetails,
                                                                 cdmDatabaseSchema = cdmDatabaseSchema,
                                                                 cohortDatabaseSchema = cohortDatabaseSchema,
                                                                 cohortTable = cohortTable,
                                                                 cohortId = comparatorCohortId,
                                                                 rowIdField = "subject_id",
                                                                 covariateSettings = tableSpecification$covariateSetting,
                                                                 aggregated = F)
      comparatorCovAggData <- FeatureExtraction::aggregateCovariates(comparatorCovData)
      ParallelLogger::logInfo(sprintf("Covariates for comparator Id %s are extracted", comparatorCohortId))
      
    }else {
      comparatorCovData <- NULL
      comparatorCovAggData <- NULL
    }
    table1 <- createTable1(targetCovAggData,
                           comparatorCovAggData,
                           specification = tableSpecification$tableSpec,
                           output = "one column",
                           showCounts = TRUE,
                           showPercent = TRUE,
                           percentDigits = 1, 
                           valueDigits = 1,
                           stdDiffDigits = 2)
    if(!is.null(fileName)){
      exportFilePath = file.path(exportFolder,fileName)
      write.csv(table1,exportFilePath)
      ParallelLogger::logInfo(sprintf("Table 1 is saved in %s", exportFilePath))
    }
    
    
  }else{
    stop("currently, stratification on outcome Id or incidence calculation is not supported")
  }
  

}
