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

# restricts to pop and saves/creates mapping
mapCovariates <- function(plpData,
                          population){
  covariates = plpData$covariates
  covariateRef = plpData$covariateRef
  
  # restrict to population stratified by outcomes
  ParallelLogger::logTrace('restricting to population according to the outcome status...')
  idx <- ffbase::ffmatch(x = covariates$rowId, table = ff::as.ff(population$rowId))
  idx <- ffbase::ffwhich(idx, !is.na(idx))
  covariates <- covariates[idx, ]
  
  covariateData = list(covariates = covariates,
                       covariateRef = covariateRef,
                       timeRef = plpData$timeRef,
                       analysisRef = plpData$analysisRef,
                       metaData = plpData$metaData)
  class (covariateData) = "covariateData"
  return(covariateData)
}
