
# compile to javascript:
# % coffee -cb map.coffee
# => map.js

kml_base_url  = "http://erikj.me/sandbox.geo/googlemaps/kml/"
kml_filenames = [ "betasso.kml", "boulder.kml", "flagstaff.kml", "gold-hill.kml", "mesa-lab.kml" ]

kml_layers    = ( new google.maps.KmlLayer (kml_base_url + f) for f in kml_filenames )

SANDBOXMAP = {} # pointer to our library
@SANDBOXMAP = SANDBOXMAP # add to global

# load_map(map_div_name) initialize google maps
# input: String, name of map div element
# output: initialized map object

SANDBOXMAP.load_map = (map_div_name) ->

  # newdelhi = new google.maps.LatLng 28.635308, 77.22496
  boulder   = new google.maps.LatLng -105.3, 40.028

  config =
    zoom: 11
    center: boulder
    mapTypeId: google.maps.MapTypeId.ROADMAP
    mapTypeControlOptions: { mapTypeIds: [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE, google.maps.MapTypeId.HYBRID, google.maps.MapTypeId.TERRAIN, 'OSM'] }

  map_div = document.getElementById map_div_name
  map = new google.maps.Map map_div, config

  # based on http://wiki.openstreetmap.org/wiki/Google_Maps_Example
  map.mapTypes.set "OSM", new google.maps.ImageMapType(
    getTileUrl: (coord, zoom) ->
      "http://tile.openstreetmap.org/" + zoom + "/" + coord.x + "/" + coord.y + ".png"
    tileSize: new google.maps.Size(256, 256)
    name: "OpenStreetMap"
    maxZoom: 18
  )

  # add layers from kml layers to map
  kml.setMap map for kml in kml_layers

  load_toggle_controls 'layer_controls'

  return map

# load_toggle_controls(control_div_name)
# input: name of layer-control div
# output: none
load_toggle_controls = (control_div_name) ->
  control_div = document.getElementById(control_div_name)

  control_div.innerHTML = ''
  i = 0
  for kml in kml_layers
    control_div.innerHTML += "<input type='checkbox' id='kml_layer_#{i}_checkbox' checked='yes' value='layer #{i}' onclick='toggle_layer(map,#{i});' /> "
    control_div.innerHTML += "#{kml_filenames[i]}<br/>"
    i += 1

  return

# toggle_layer(map, layer) toggle display of layer in map
# input: google.maps.Map Object, google maps layer Object
# output: TBD
toggle_layer = (map, i) ->
  checkbox_div = "kml_layer_#{i}_checkbox"
  if document.getElementById(checkbox_div).checked
    kml_layers[i].setMap map
  else
    kml_layers[i].setMap null
