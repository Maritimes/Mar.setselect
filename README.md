## Mar.setselect

This package consists of a single function that was created to assist with the task of randomly 
assigning set locations with strata.  At a minimum, the "setselect" function accepts 4 parameters:

- **stationData**:  a csv file like the one below; 
- **stationDataField**: a string identifying the strata field within the csv file;
- **strata_sf**: an sf polygon file; and
- **strataField**: a string identifying the strata field within the sf polygon.
  
It uses this information to randomly select a user-specified number of "stations" within each 
polygon (or "stratum").

```
> head(stationData)
```
|  STRATUM |PRIMARY |ALTERNATE |SECONDARY|
|:--------:|:------:|:--------:|:-------:|
|      5Z1 |      6 |        3 |        4|
|      5Z2 |     11 |        6 |       NA|
|      5Z3 |      5 |        2 |        2|
|      5Z4 |      4 |        2 |        2|
|      ... |    ... |      ... |      ...|

As shown above, each Stratum has a unique identifier (e.g. "5Z2"), and for each stratum, the user 
can specify the number of Primary, Secondary and Alternate stations that should be generated.

When run, the function returns an sf object of the positions, as well as generating an excel file, 
and a spatial gpkg file containing the same information. 

### Adding Additional Information from Other Spatial Data
Additional information can be added to the output data.  For example, it might be important to know
which NAFO zone, Marine Protected Area or which fishing area contains each of the output sets.  By 
providing additional sf files to the parameters "addExtData1_sf" and/or "addExtData2_sf", 
and identifying which fields should be added to the output (via the parameters "addExtDataFields1"
and/or addExtDataFields2), this information can easily be added.  

### Avoiding Assignment of Sets in Particular Areas
Cases exist when certain areas are known "bad bottom", and should not be assigned sets.  For example, 
troublesome wrecks or areas of unexploded ordinance or  might exist within the study area.  By 
submitting an sf object to the parameter "avoid_sf", the function will ensure that no sets are 
generated within that footprint.

### Outputs
By default, this function will return an sf object of the results, as well as writing both an xls 
and a (GIS) gpkg file to the current working directory.  These outputs can be omitted by changing 
either writexls or writegpkg to FALSE.

### Additional Details
In cases where a particular strata is geographically small, but a large number of sets is desired, 
the function will try 100 times to fit the requested number of sets.  The number of attempts can be 
increased by changing the value of the parameter "tryXTimes".  By default, the randomly generated 
positions will be at least 4 nautical miles apart, but that value can be changed via the parameter 
"minDistNM".  One might also consider reducing the number of requested stations for this stratum.

This function requires the provision of a value for "localCRS", and any sf objects supplied to it 
will be reprojected as part of the process.  localCRS defaults to 2961, which corresponds with UTM 
Zone 20N, and is appropriate for the Maritimes/Scotian Shelf.  

### Example
```{r, example, eval=F}
avoidAreaSf <- sf::st_read("C:/exclusionAreas/badBottom.shp")
mpaSf    <- sf::st_read("C:/infoAreas/oceansAreas.shp")
nafoSf   <- Mar.data::NAFOSubunits_sf
Summer_2024<- setSelect(stationData = "C:/Users/McMahonM/Summer_4VWX5Z_Stations2024.csv",
                        outName =  "Georges_5Z_2025",
                        stationDataField = "STRATUM",
                        strata_sf = Mar.data::Strata_Mar_sf,strataField = "StrataID",
                        addExtData1_sf = nafoSf, addExtDataFields1 = "NAFO",
                        addExtData2_sf = mpaSf, addExtDataFields2 = c("NAME_E","ZONE_E", "URL_E", "REGULATION"), 
                        avoid_sf = avoidAreaSf)
```
