
library(Mar.utils)
avoidAreaSf <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/Groups/Groundfish/SetSelector/exclusionAreas/20230626/avoidAreas_0Buff_Dissolve.shp", quiet = T)
oceansSf    <- sf::st_read("C:/git/Maritimes/Mar.setselect/inst/oceansAreas/oceansAreas.shp", quiet = T)
Summer_2024<- setSelect(stationData = "C:/Users/McMahonM/Downloads/Summer_4VWX5Z_Stations2024.csv",
                        stationData_StratField = "STRATUM",
                        strata_sf = Mar.data::Strata_Mar_sf,strata_sf_StratField = "StrataID",
                        addExtData1_sf = Mar.data::NAFOSubunits_sf, addExtDataFields1 = "NAFO",
                        addExtData2_sf = oceansSf, addExtDataFields2 = c("NAME_E","ZONE_E", "URL_E", "REGULATION"), 
                        avoid_sf = avoidAreaSf)

