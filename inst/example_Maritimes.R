# devtools::install_github('Maritimes/Mar.setselect')
library(sf)
library(Mar.setselect)
setwd("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/!group_Groundfish/SetSelector/2025/results")

this_avoid_sf <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/!group_Groundfish/SetSelector/2025/spatialFiles/avoidAreas.shp")

oceans_areas_sf <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/!group_Groundfish/SetSelector/2025/spatialFiles/oceansAreas_MAR.shp")
oceans_areas_sf <- sf::st_set_crs(oceans_areas_sf, 3978)



Spring_4X_2025 <- setSelect(stationData = "c:/Users/McMahonM/OneDrive - DFO-MPO/Support/!group_Groundfish/SetSelector/2025/Spring_4X_RM.csv",
                            stationDataField = "STRATUM",
                            strata_sf = Mar.data::Strata_Mar_sf, strataField = "StrataID", 
                            addExtData1_sf = Mar.data::NAFOSubunits_sf, addExtDataFields1 = "NAFO",
                            addExtData2_sf = oceans_areas_sf, 
                            addExtDataFields2 = c("NAME_E","ZONE_E"), 
                            avoid_sf = this_avoid_sf, )


Georges_5Z_2025 <- setSelect(stationData = "c:/Users/McMahonM/OneDrive - DFO-MPO/Support/!group_Groundfish/SetSelector/2025/Georges_5Z_RM.csv.csv",
                              stationDataField = "STRATUM",
                              strata_sf = Mar.data::Strata_Mar_sf, strataField = "StrataID", 
                              addExtData1_sf = Mar.data::NAFOSubunits_sf, addExtDataFields1 = "NAFO",
                              addExtData2_sf = oceans_areas_sf, 
                              addExtDataFields2 = c("NAME_E","ZONE_E"), 
                              avoid_sf = this_avoid_sf)
