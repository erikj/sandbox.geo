# google maps proof of concept

<http://erikj.me/googlemaps/>

- draw map
- load kml
  - kml must be publicly accessible
- toggle kml
  - <http://groups.google.com/group/google-maps-js-api-v3/browse_thread/thread/fb43dec77a9f1cf3>

## reference

- <http://www.digimantra.com/google/started-google-map-api-v3/>
- <http://code.google.com/apis/maps/documentation/javascript/>
- <http://code.google.com/apis/maps/documentation/javascript/tutorial.html>
- <http://code.google.com/apis/maps/documentation/javascript/reference.html#KmlLayer>
- <http://code.google.com/apis/maps/documentation/javascript/overlays.html>
- <http://councilsites.posterous.com/upgrade-to-google-maps-v2-oily-rag-view>
- <http://code.google.com/apis/maps/documentation/javascript/examples/layer-kml.html>
- <http://www.marinegis.org/GoogleMaps/Aquaculture/>
 - [layer controls over map](http://stackoverflow.com/questions/3225170/google-maps-v2-div-inside-or-over-map)
- [open-street-maps base layer](http://wiki.openstreetmap.org/wiki/Google_Maps_Example)


## licensing / costs

- <http://code.google.com/apis/maps/terms.html>

- <http://code.google.com/apis/maps/faq.html>

### What information is sent to Google when I use the JavaScript Maps API?

*When using the JavaScript Maps API, the following information is sent to Google:
Map size and location for retrieving map tiles and copyrights
Addresses for geocoding
Direction and Elevation requests
Locations around which to search for Places
KML when using KmlLayer (V3) or GGeoXml (V2)*

### What usage limits apply to the Maps API?

*Web sites and applications using each of the Maps API may at no cost generate:
up to 25,000 map loads per day for each API
up to 2,500 map loads per day that have been modified using the Styled Maps feature
If your application exceeds these usage limits you must respond in one of the following ways in order to continue using the Maps API in your application:
Modify your Maps API application such that the number of map loads generated per day is below the usage limit for each API that your application uses;
Enroll for automated billing of excess map loads; or
Purchase a Maps API for Business license*

### what is the API key for in v3?

- <http://stackoverflow.com/questions/2769148/whats-the-api-key-for-in-google-maps-api-v3>
- <http://code.google.com/apis/maps/documentation/javascript/tutorial.html#api_key>

used by the developer to monitor their application's usage of API

### costs

- first 25k map loads free
- then $4 / 1000 map loads

#### What constitutes a 'map load' in the context of the usage limits that apply to the Maps API?

A single map load occurs when:

1. map is displayed using the Maps JavaScript API (V2 or V3) when loaded by a web page or application;
1. SWF that loads the Maps API for Flash is loaded by a web page or application; or
1. single request is made for a map image from the Static Maps API.
1. single request is made for a panorama image from the Street View Image API.
