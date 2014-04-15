## StormChaser


Description: StormChaser is a data-visualization app for the recorded history of cyclones in the United States.  Our app utilizes data from our StormChaser API, an open API that has freed the past 63 years of cyclone data from the clutches of a mammoth CSV file and integrated it with data from Forecast.io and Google Maps API to provide a comprehensive data-set for each cyclone.

Live Site: http://stormchaser.herokuapp.com

Authors:
Patrick Brennan  |  patrick@patrickbrennan.co
Bethany Nagel  |  bethanylnagel@gmail.com

Tech Stack:
This application utilizes Rails, Ruby, Javascript, MapBox/Leaflet, Google Visualization API, Forecast.io API

## StormChaser API:


The StormChaser API gives access to 63 years of cyclone data in the United States, from 1950 to 2013. The data is from a .csv file provided by NOAA's NWS Storm Prediction Center and can be found at http://www.spc.noaa.gov/wcm/data/1950-2013Torn.csv. Data on the weather at the cyclone touchdown location is also provided by using historical data from the Forecast.io API. Various searches and selectors in the API get requests allow for a narrowed and more selective search. The API replies to requests are replied to strictly in JSON.

Here is the available data:

| Data Name | Description | Type | Location in the JSON |
| ------------- | ------------- | ------------- | ------------- |
| Day | Day of the month the cyclone touched down | Integer | cyclone.date.day |
| Month | Month of the year the cyclone touched down | Integer | cyclone.date.month |
| Year | Year the cyclone touched down | Integer | cyclone.date.year |
| Hour | Hour the cyclone touched down (24 hr format) | Integer | cyclone.date.hour |
| Minute | Minute the cyclone touched down | Integer | cyclone.date.minute |
| Time Zone |  | Integer | cyclone.date.timeZone |
| Fujita Scale | Strength of the cyclone, click here for more information | Integer | cyclone.strength.fScale |
| Width | Width of cyclone in yards | Integer | cyclone.strength.width |
| Injuries | Number of injuries caused by the cyclone | Integer | cyclone.loss.injuries |
| Fatalities | Number of fatalities caused by the cyclone | Integer | cyclone.loss.fatalities |
| Property Loss | Property loss caused by the cyclone, in millions of $ | Float | cyclone.loss.propertyLoss |
| Crop Loss | Crop loss caused by the cyclone, in millions of $ | Float | cyclone.loss.cropLoss |
| Starting Latitude | Starting Latitude of the cyclone path | Float | cyclone.location.startLat |
| Starting Longitude | Starting Longitude of the cyclone path | Float | cyclone.location.startLong |
| Stopping Latitude | Stopping Latitude of the cyclone path | Float | cyclone.location.stopLat |
| Stopping Longitude | Stopping Longitude of the cyclone path | Float | cyclone.location.stopLong |
| Distance Travelled | Distance the cyclone travelled, in miles | Float | cyclone.location.distance |
| State | State the cyclone path starts in (Based off of Starting Lat and Starting Long) | String | cyclone.location.state |
| County Code 1 | Code of county cyclone passed through or 0 if no county | Integer | cyclone.location.countyCodeOne |
| County Code 2 | Code of county cyclone passed through or 0 if the cyclone passed through 1 or fewer counties | Integer | cyclone.location.countyCodeTwo |
| County Code 3 | Code of county cyclone passed through or 0 if the cyclone passed through 2 or fewer counties | Integer | cyclone.location.countyCodeThree |
| County Code 4 | Code of county cyclone passed through or 0 if the cyclone passed through 3 or fewer counties | Integer | cyclone.location.countyCodeFour |
| # States Crossed | Number of states the cyclone passed through | Integer | cyclone.location.statesCrossed |
| Complete Track | Is the path a complete track (true) or part of a partial track for multi-state cyclones (false) | Boolean | cyclone.path.completeTrack |
| Segment # | Current segment of the cyclone, 1 for all complete paths | Integer | cyclone.path.segmentNum |
| Avg Fatalities for All Records | Average fatalities for all cyclone records available | Float | cyclone.average.all.fatalities |
| Avg Injuries for All Records | Average injuries for all cyclone records available | Float | cyclone.average.all.injuries |
| Avg Crop Loss for All Records | Average crop loss for all cyclone records available (millions $) | Float | cyclone.average.all.cropLoss |
| Avg Property Loss for All Records | Average property loss for all cyclone records available (millions $) | Float | cyclone.average.all.propertyLoss |
| Avg Fujita Scale for All Records | Average F-Scale for all cyclone records available | Float | cyclone.average.all.fScale |
| Avg Distance for All Records | Average distance for all cyclone records available (miles) | Float | cyclone.average.all.distance |
| Avg Fatalities for Touchdown Year Records | Average number of fatalities for all cyclone records available for the touchdown year | Float | cyclone.average.year.fatalities |
| Avg Injuries for Touchdown Year Records | Average number of injuries for all cyclone records available for the touchdown year | Float | cyclone.average.year.injuries |
| Avg Crop Loss for Touchdown Year Records | Average number of crop loss for all cyclone records available for the touchdown year (millions $) | Float | cyclone.average.year.cropLoss |
| Avg Property Loss for Touchdown Year Records | Average number of property loss for all cyclone records available for the touchdown year (millions $) | Float | cyclone.average.year.propertyLoss |
| Avg Fujita Scale for Touchdown Year Records | Average number of F-scale for all cyclone records available for the touchdown year | Float | cyclone.average.year.fScale |
| Avg Distance for Touchdown Year Records | Average number of distance for all cyclone records available for the touchdown year (miles) | Float | cyclone.average.year.distance |
| Touchdown Temperature | Temperature at time of cyclone touchdown (F) | Float | touchdownWeather.temperature |
| Touchdown Pressure | Pressure at time of cyclone touchdown (??) | Float | touchdownWeather.pressure |
| Touchdown Wind Speed | Wind speed at time of cyclone touchdown (mph) | Float | touchdownWeather.windSpeed |
| Touchdown Wind Bearing | Wind bearing at time of touchdown (degrees) | Integer | touchdownWeather.windBearing |
| Hourly Temperature | Temperature at the location of the cyclone touchdown at a given hour during the day of the touchdown (F) | Float | historicalWeather[“hour”].temperature |
| Hourly Pressure | Pressure at the location of the cyclone touchdown at a given hour during the day of the touchdown (??) | Float | historicalWeather[“hour”].pressure |
| Hourly Wind Speed | Wind speed at the location of the cyclone touchdown at a given hour during the day of the touchdown (mph) | Float | historicalWeather[“hour”].windSpeed |
| Hourly Wind Bearing | Wind bearing at the location of the cyclone touchdown at a given hour during the day of the touchdown (degrees) | Float | historicalWeather[“hour”].windBearing |
| Cyclone ID | ID given to the cyclone by the database | Integer | historicalWeather[“hour”].id |

All Cyclone data can be accessed through selectors and searches. Searches are ways to order the data or to provide complex searches given a set of parameters. All searches are as follows:

| Search Name | Description | URL |
| ------------- | ------------- | ------------- |
| Strongest | Rank tornadoes by F-scale, strongest first | http://stormchaser.herokuapp.com/api/v1/search/strongest.json |
| Deadliest | Rank tornadoes by fatalities, most fatalities first | http://stormchaser.herokuapp.com/api/v1/search/deadliest.json |
| Costliest | Rank cyclones by property damage, most damage first | http://stormchaser.herokuapp.com/api/v1/search/costliest.json |
| Deadly | Only return deadly cyclones | http://stormchaser.herokuapp.com/api/v1/search/deadly.json |
| Scale 5 | Only return 5 scale cyclones | http://stormchaser.herokuapp.com/api/v1/search/scale_5.json |
| Same Day Cyclones | Return cyclones that occurred on the same day as a given cyclone’s id | http://stormchaser.herokuapp.com/api/v1/search/same_day,id:300.json |
| Radius Search | Given a location and a radius, find all tornadoes that have travelled through the resulting circle. | http://stormchaser.herokuapp.com/api/v1/search/radius_search,city:austin,state:tx,radius:25.json |