
library(sf)

quebecStations <- "C:/Users/McMahonM/OneDrive - DFO-MPO/Support/Individuals/ChamberlainJ/QUE_Example/inputs/QuebecExample.csv"
quebecStrata_sf <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/Individuals/ChamberlainJ/QUE_Example/inputs/strataQuebec.shp", quiet = T)
# L'identifiant de notre strate est "StratumID"
quebecAvoid_sf  <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/Individuals/ChamberlainJ/QUE_Example/inputs/noTrawlQuebec.shp", quiet = T)
# Les noms des champs ne nous intéressent pas ici.  Nous voulons simplement éviter ces zones - \
# aucune station ne doit se trouver à l'intérieur de ces polygones.  Si vous disposez d'un csv (
#c'est-à-dire d'un point), vous pouvez simplement les tamponner dans un SIG et en faire des 
#polygones ?
quebecMPAs_sf   <- sf::st_read("C:/Users/McMahonM/OneDrive - DFO-MPO/Support/Individuals/ChamberlainJ/QUE_Example/inputs/mpaQuebec.shp", quiet = T)
# Dans mon exemple ci-dessous, nous voulons que les champs suivants soient ajoutés aux données de 
# sortie pour tous les points situés à l'intérieur de ces polygones:
# c("NAME_E", "URL_E", "ZONE_E")
quebecNAFO_sf   <- Mar.data::NAFOSubunits_sf
#Ce n'est pas sur l'image, mais si vous voulez ajouter des champs d'un autre fichier, vous pouvez 
# le faire.  Dans mon exemple, je vais ajouter le champ "NAFO" de mon fichier "quebecNAFO_sf"

#devtools::install_github('Maritimes/Mar.setselect')
library(Mar.setselect)
QueExample<- setSelect(stationData = quebecStations, stationDataField = "STRATUM",
                        strata_sf = quebecStrata_sf, strataField = "StratumID",
                        addExtData1_sf = quebecMPAs_sf, addExtDataFields1 = c("NAME_E","ZONE_E", "URL_E", "REGULATION"),
                        addExtData2_sf = quebecNAFO_sf, addExtDataFields2 = "NAFO", 
                        avoid_sf = quebecAvoid_sf, 
                        tryXTimes = 100, minDistNM = 3)

