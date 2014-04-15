## StormChaser


Description: StormChaser is a data-visualization app for the recorded history of cyclones in the United States.  Our app utilizes data from our StormChaser API, an open API that has freed the past 63 years of cyclone data from the clutches of a mammoth CSV file and integrated it with data from Forecast.io and Google Maps API to provide a comprehensive data-set for each cyclone.

Live Site: http://stormchaser.herokuapp.com

Authors:
Bethany Nagel  |  bethanylnagel@gmail.com
Patrick Brennan  |  patrick@patrickbrennan.co

Tech Stack:
This application utilizes Rails, Ruby, Javascript, MapBox/Leaflet, Google Visualization API, Forecast.io API

## StormChaser API:


The StormChaser API gives access to 63 years of cyclone data in the United States, from 1950 to 2013. The data is from a .csv file provided by [NOAA's NWS Storm Prediction Center](http://www.spc.noaa.gov/wcm/#data). Data on the weather at the cyclone touchdown location is also provided by using historical data from the Forecast.io API. Various searches and selectors in the API get requests allow for a narrowed and more selective search. The API replies to requests are replied to strictly in JSON.

Here is the available data:

| Data Name | Description | Type | Location in the JSON |
| ------------- | ------------- | ------------- | ------------- |
| Cyclone ID | ID given to the cyclone by the database | Integer | historicalWeather[“hour”].id |
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
| **Average for All Records** | | | |
| Fatalities | Average fatalities for all cyclone records available | Float | cyclone.average.all.fatalities |
| Injuries | Average injuries for all cyclone records available | Float | cyclone.average.all.injuries |
| Crop Loss | Average crop loss for all cyclone records available (millions $) | Float | cyclone.average.all.cropLoss |
| Property Loss | Average property loss for all cyclone records available (millions $) | Float | cyclone.average.all.propertyLoss |
| Fujita Scale| Average F-Scale for all cyclone records available | Float | cyclone.average.all.fScale |
| Distance | Average distance for all cyclone records available (miles) | Float | cyclone.average.all.distance |
| **Average for Touchdown Year Records** | | | |
| Fatalities | Average number of fatalities for all cyclone records available for the touchdown year | Float | cyclone.average.year.fatalities |
| Injuries | Average number of injuries for all cyclone records available for the touchdown year | Float | cyclone.average.year.injuries |
| Crop Loss | Average number of crop loss for all cyclone records available for the touchdown year (millions $) | Float | cyclone.average.year.cropLoss |
| Property Loss | Average number of property loss for all cyclone records available for the touchdown year (millions $) | Float | cyclone.average.year.propertyLoss |
| Fujita Scale | Average number of F-scale for all cyclone records available for the touchdown year | Float | cyclone.average.year.fScale |
| Distance | Average number of distance for all cyclone records available for the touchdown year (miles) | Float | cyclone.average.year.distance |
| **Weather at Touchdown** | (If available) | | |
| Temperature | Temperature at time of cyclone touchdown (F) | Float | touchdownWeather.temperature |
| Pressure | Pressure at time of cyclone touchdown (mb) | Float | touchdownWeather.pressure |
| Wind Speed | Wind speed at time of cyclone touchdown (mph) | Float | touchdownWeather.windSpeed |
| Wind Bearing | Wind bearing at time of touchdown (degrees) | Integer | touchdownWeather.windBearing |
| **Hourly Weather during Touchdown Day** | (If available) | | |
| Temperature | Temperature at the location of the cyclone touchdown at a given hour during the day of the touchdown (F) | Float | historicalWeather[“hour”].temperature |
| Pressure | Pressure at the location of the cyclone touchdown at a given hour during the day of the touchdown (mb) | Float | historicalWeather[“hour”].pressure |
| Wind Speed | Wind speed at the location of the cyclone touchdown at a given hour during the day of the touchdown (mph) | Float | historicalWeather[“hour”].windSpeed |
| Wind Bearing | Wind bearing at the location of the cyclone touchdown at a given hour during the day of the touchdown (degrees) | Float | historicalWeather[“hour”].windBearing |

### Searches

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

### Selectors

Selectors are ways to describe what types of data to return. This is done by selecting an exact answer (state:tx for all cyclones that have occured in the state of Texas), or using our + (>=) and - (<=) modifiers at the end of the selector (f_scale:3+ for all cyclones with an f_scale of 3 or greater). The available selectors can be found below:

| Selector Name | Description | URL |
| ------------- | ------------- | ------------- |
| Records | The number of records to return (standard is 500) | http://stormchaser.herokuapp.com/api/v1/cyclones/records:100.json |
| Year* | Select the year the cyclone touched down  | http://stormchaser.herokuapp.com/api/v1/cyclones/year:2011.json |
| Month* | Select the month the cyclone touched down | http://stormchaser.herokuapp.com/api/v1/cyclones/month:3.json |
| Day* | Select the day the cyclone touched down | http://stormchaser.herokuapp.com/api/v1/cyclones/day:5.json |
| Fatalities* | Select the number of fatalities caused by the cyclone | http://stormchaser.herokuapp.com/api/v1/cyclones/fatalities:1.json |
| Injuries* | Select the number of injuries caused by the cyclone | http://stormchaser.herokuapp.com/api/v1/cyclones/injuries:1.json |
| State | Select the state the cyclone touched down | http://stormchaser.herokuapp.com/api/v1/cyclones/state:tn.json |
| Property Damage* | Select how much property damage is caused | http://stormchaser.herokuapp.com/api/v1/cyclones/property_loss:10.json |
| Crop Damage* | Select how much crop damage is caused | http://stormchaser.herokuapp.com/api/v1/cyclones/crop_loss:1.json |
| F-Scale* | Select the Fujita Scale of the cyclone | http://stormchaser.herokuapp.com/api/v1/cyclones/f_scale:4+.json |
| Hour* | Select the hour the cyclone touched down | http://stormchaser.herokuapp.com/api/v1/cyclones/hour:3-.json |
| Distance* | Select the distance the cyclone travelled | http://stormchaser.herokuapp.com/api/v1/cyclones/distance:200+.json |
| Complete Track | Return only cyclones with a complete track | http://stormchaser.herokuapp.com/api/v1/cyclones/complete_track:true.json |

### Examples

| Example | URL for Example |
| ------------- | ------------- |
| All Cyclones | http://stormchaser.herokuapp.com/api/v1/cyclones.json |
| Cyclone with id 5 | http://stormchaser.herokuapp.com/api/v1/cyclones/5.json |
| All cyclones in 2011 with scale >= 4 | http://stormchaser.herokuapp.com/api/v1/cyclones/year:2011,f_scale:4+.json |
| All cyclones in 2011 with scale >= 4, ranked strongest to weakest | http://stormchaser.herokuapp.com/api/v1/search/strongest/year:2011,f_scale:4+.json |
| 20 deadly cyclones that have crop damage | http://stormchaser.herokuapp.com/api/v1/search/deadly/crop_loss:1+,records:20.json |
| Find all cyclones that have occurred within 25 miles of Austin, TX | http://stormchaser.herokuapp.com/api/v1/search/radius_search,city:Austin,state:TX,radius:25.json |
| Find all cyclones that have occurred within 25 miles of Austin, TX in 2010-now | http://stormchaser.herokuapp.com/api/v1/search/radius_search,city:Austin,state:TX,radius:25/year:2010+.json |
