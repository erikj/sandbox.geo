# based on http://wiki.openstreetmap.org/wiki/OpenLayers_Simple_Example

# compile to javascript:
# % coffee -c map.coffee
# => map.js

CATMAP = {}
@CATMAP = CATMAP

# load_map(map_name): initialize openlayers w/ open-street-maps and google-maps base layers
# scope: global, called from rendered html pages
# input: String, dom id of map element
# output: initialized map object
CATMAP.load_map = (map_div_name) ->

  # projections
  geoProj  = new OpenLayers.Projection "EPSG:4326"
  mercProj = new OpenLayers.Projection "EPSG:900913"

  # initialize openlayers map

  controls = [ new OpenLayers.Control.MousePosition({displayProjection:geoProj})
                                            # display lat/lon of mouse's map position in lower-right corner
    new OpenLayers.Control.OverviewMap      # toggled, lower-right corner
    new OpenLayers.Control.KeyboardDefaults # +/- zoom in/out, move map via arrow keys
    # new OpenLayers.Control.Zoom 
    new OpenLayers.Control.LayerSwitcher    # toggled, upper-right corner, base-layer select, and vector and image checkboxes
    new OpenLayers.Control.Navigation ]     # move map, zoom in/out w/ via mouse input

  map = new OpenLayers.Map map_div_name,
      controls:controls
  CATMAP.map = map
  # layer for open-streep maps
  osm = new OpenLayers.Layer.OSM()
  map.addLayer osm

  # google-maps layers
  # based on http://openlayers.org/dev/examples/google-v3.html
  # docs: http://dev.openlayers.org/apidocs/files/OpenLayers/Layer/Google-js.html
  gterr = new OpenLayers.Layer.Google "Google Terrain",   { type: google.maps.MapTypeId.TERRAIN }
  gmap  = new OpenLayers.Layer.Google "Google Streets",   { numZoomLevels: 20 }
  ghyb  = new OpenLayers.Layer.Google "Google Hybrid",    { type: google.maps.MapTypeId.HYBRID,    numZoomLevels: 20 }
  gsat  = new OpenLayers.Layer.Google "Google Satellite", { type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22 }

  map.addLayers [ gterr, gmap, ghyb, gsat ]

  boulder = new OpenLayers.LonLat -105.3, 40.028
  salina  = new OpenLayers.LonLat -97.6459, 38.7871

  # center  = boulder
  center  = salina

  map.setCenter center.transform(geoProj, mercProj), 5

  # layer styling
  colors = [ 'ff0000', '00ff00', '0000ff', 'ffd700', 'ff00ff', '00ffff' ]
  styles = ( new OpenLayers.Style('strokeWidth': 3, 'strokeColor': '#' + color) for color in colors )

  # kml layers
  kmlDir = "kml"
  # kmlFilenames = [ "betasso.kml", "boulder.kml", "flagstaff.kml", "gold-hill.kml", "mesa-lab.kml" ]

  # kmlFilenames = [ "ge.research.201205090000.N677F_flight_track.kml" ]

  # kmlFilenames = [ "ge.research.201205090000.N677F_flight_track.kml",
  #   "ge.research.201205111738.NA817_flight_track.kml",
  #   "ge.SMART-R.201205131825.NOXP_location.kml",
  #   "ge.SMART-R.201205111750.NOXP_location.kml",
  #   "ge.NCAR_ISS.201205111652.location.kml" ]

  # kmlLayers = []

  # for kmlFilename, i in kmlFilenames
  #   kmlLayers.push new OpenLayers.Layer.Vector 'KML' #kmlFilename, kmlDir + "/" + kmlFilename,
  #       strategies: [ new OpenLayers.Strategy.Fixed() ]
  #       protocol: new OpenLayers.Protocol.HTTP
  #           url:    kmlDir + "/" + kmlFilename
  #           format: new OpenLayers.Format.KML
  #               extractStyles: true
  #               extractAttributes: true

  # map.addLayers kmlLayers

  # for kmlLayer in kmlLayers
  #   # http://dev.openlayers.org/releases/OpenLayers-2.11/examples/sundials.html
  #   kmlLayer.events.on
  #       "featureselected":   onFeatureSelect
  #       "featureunselected": onFeatureUnselect

  # TODO: draw a line from Boulder to Salina
  # https://github.com/NCAR-Earth-Observing-Laboratory/catalog-maps/issues/69
  # lineLayer = new OpenLayers.Layer.Vector("Line Layer")
  # map.addControl( new OpenLayers.Control.DrawFeature(lineLayer, OpenLayers.Handler.Path) )

  # # points =[ new OpenLayers.Geometry.Point(lon1, lat1), new OpenLayers.Geometry.Point(lon2, lat2) ]
  # points = [ salina, boulder ]

  # line = new OpenLayers.Geometry.LineString(points)

  # style = { strokeColor: '#0000ff'
  #   strokeOpacity: 0.5
  #   strokeWidth: 5
  # }

  # lineFeature = new OpenLayers.Feature.Vector(line, null, style)
  # lineLayer.addFeatures( [ lineFeature ])
  
  # map.addLayer lineLayer

  # kmlSelector = new OpenLayers.Control.SelectFeature kmlLayers
  # map.addControl kmlSelector
  # kmlSelector.activate()

  # > Terascan claims the bounding box is:
  #     N: 49.6830
  #     S: 27.6074
  #     E: -89.5877
  #     W: -125.4483


  # goesImageLayer = new OpenLayers.Layer.Image(
  #   'goes-13-western-us-spherical-mercator.jpg',
  #   'img/goes-13-western-us-spherical-mercator.jpg',
  #   new OpenLayers.Bounds(-125.4483, 27.6074, -89.5877, 49.6830).transform(geoProj, mercProj),
  #   new OpenLayers.Size(866,693),
  #     isBaseLayer: false
  #     alwaysInRange: true
  #   )
  # map.addLayers [goesImageLayer]
  # goesImageLayer.setOpacity .5

  # GOES-13 Box Coordinates:
  # N: 47.9302
  # S: 22.9482
  # E: -65.5498
  # W: -105.6473

  # sasGoesBounds = new OpenLayers.Bounds(-105.6473, 22.87, -65.46, 47.9302).transform(geoProj, mercProj)

  # goesCh1Layer = new OpenLayers.Layer.Image(
  #   'ops.GOES-13.201305220232.4km_ch1_vis.jpg',
  #   'img/ops.GOES-13.201305220232.4km_ch1_vis.jpg',
  #   sasGoesBounds,
  #   new OpenLayers.Size(866,693),
  #     isBaseLayer: false
  #     alwaysInRange: true
  #   )

  # goesCh4Layer = new OpenLayers.Layer.Image(
  #   'ops.GOES-13.201305220332.4km_ch4_thermal-IR.jpg',
  #   'img/ops.GOES-13.201305220332.4km_ch4_thermal-IR.jpg',
  #   sasGoesBounds,
  #   new OpenLayers.Size(866,693),
  #     isBaseLayer: false
  #     alwaysInRange: true
  #   )

  # map.addLayers [goesCh1Layer, goesCh4Layer]

  # goesCh1Layer.setOpacity .5

  # goesCh4Layer.setOpacity .5



  # 4km:

  # minimum_latitude: 27.6074
  # maximum_latitude: 49.6830
  # minimum_longitude: -125.4483
  # maximum_longitude: -89.5877

  mpex4kmGoesBounds = new OpenLayers.Bounds(-125.4483, 27.55, -89.52, 49.6830).transform(geoProj, mercProj)

  # ops.GOES-15.201305231830.4km_ch1_vis.jpg
  mpex4kmCh1Layer = new OpenLayers.Layer.Image(
    'ops.GOES-15.201305231830.4km_ch1_vis.jpg',
    'img/ops.GOES-15.201305231830.4km_ch1_vis.jpg',
    mpex4kmGoesBounds,
    new OpenLayers.Size(1000,800),
      isBaseLayer: false
      alwaysInRange: true
    )

  # ops.GOES-15.201305231830.4km_ch3_water_vapor.jpg
  mpex4kmCh3Layer = new OpenLayers.Layer.Image(
    'ops.GOES-15.201305231830.4km_ch3_water_vapor.jpg',
    'img/ops.GOES-15.201305231830.4km_ch3_water_vapor.jpg',
    mpex4kmGoesBounds,
    new OpenLayers.Size(1000,800),
      isBaseLayer: false
      alwaysInRange: true
    )

  # ops.GOES-15.201305231800.4km_ch4_thermal-IR.jpg
  mpex4kmCh4Layer = new OpenLayers.Layer.Image(
    'ops.GOES-15.201305231800.4km_ch4_thermal-IR.jpg',
    'img/ops.GOES-15.201305231800.4km_ch4_thermal-IR.jpg',
    mpex4kmGoesBounds,
    new OpenLayers.Size(1000,800),
      isBaseLayer: false
      alwaysInRange: true
    )


  # 1km NGP:

  # minimum_latitude: 33.6552
  # maximum_latitude: 47.4165
  # minimum_longitude: -108.7010
  # maximum_longitude: -90.4855

  mpex1kmNgpGoesBounds = new OpenLayers.Bounds(-108.7010, 33.63,  -90.44, 47.4165).transform(geoProj, mercProj)

  # ops.GOES-15.201305231830.1km_NGP_ch1_vis.jpg
  mpex1kmNgpLayer = new OpenLayers.Layer.Image(
    'ops.GOES-15.201305231830.1km_NGP_ch1_vis.jpg',
    'img/ops.GOES-15.201305231830.1km_NGP_ch1_vis.jpg',
    mpex1kmNgpGoesBounds,
    new OpenLayers.Size(1024,1024),
      isBaseLayer: false
      alwaysInRange: true
    )

  # 1km SGP:

  # minimum_latitude: 26.8635
  # maximum_latitude: 40.6155
  # minimum_longitude: -107.4267
  # maximum_longitude: -90.8137

  mpex1kmSgpGoesBounds = new OpenLayers.Bounds(-107.4267, 26.85, -90.78, 40.57).transform(geoProj, mercProj)

  # ops.GOES-15.201305231830.1km_SGP_ch1_vis.jpg
  mpex1kmSgpLayer = new OpenLayers.Layer.Image(
    'ops.GOES-15.201305231830.1km_SGP_ch1_vis.jpg',
    'img/ops.GOES-15.201305231830.1km_SGP_ch1_vis.jpg',
    mpex1kmSgpGoesBounds,
    new OpenLayers.Size(1024,1024),
      isBaseLayer: false
      alwaysInRange: true
    )

  map.addLayers [ mpex4kmCh1Layer, mpex4kmCh3Layer, mpex4kmCh4Layer ]
  map.addLayers [ mpex1kmNgpLayer, mpex1kmSgpLayer]

  # mpex4kmCh1Layer.setOpacity .5
  # mpex4kmCh3Layer.setOpacity .5
  # mpex4kmCh4Layer.setOpacity .5

  mpex1kmNgpLayer.setOpacity .5
  mpex1kmSgpLayer.setOpacity .5

  # imageLayer = new OpenLayers.Layer.Image(
  #   'business cat',
  #   'img/business-cat.jpg', # from http://troll.me/images/business-cat-needs/business-cat-needs.jpg
  #   new OpenLayers.Bounds(-105.37, 40.00, -105.21, 40.11).transform(geoProj, mercProj),
  #   new OpenLayers.Size(552,552),
  #     isBaseLayer: false
  #     alwaysInRange: true
  #   )
  # map.addLayers [imageLayer]
  # imageLayer.setOpacity .5
  # 
  # imageLayer2 = new OpenLayers.Layer.Image(
  #   'research.CHILL.201106140005.DBZ.png',
  #   'http://catalog.eol.ucar.edu/dc3_2011/research/chill/20110614/research.CHILL.201106140005.DBZ.png',
  #   new OpenLayers.Bounds(-106.42, 39.0733, -102.675, 41.8267).transform(geoProj, mercProj),
  #   new OpenLayers.Size(1070,1020),
  #     isBaseLayer: false
  #     alwaysInRange: true
  # )
  # 
  # imageLayer3 = new OpenLayers.Layer.Image(
  #   'research.CHILL.201106140005.ZDR.png',
  #   'http://catalog.eol.ucar.edu/dc3_2011/research/chill/20110614/research.CHILL.201106140005.ZDR.png',
  #   new OpenLayers.Bounds(-106.42, 39.0733, -102.675, 41.8267).transform(geoProj, mercProj),
  #   new OpenLayers.Size(1070,1020),
  #     isBaseLayer: false
  #     alwaysInRange: true
  # )
  # 
  # imageLayer4 = new OpenLayers.Layer.Image(
  #   'research.CHILL.201106140005.VEL.png',
  #   'http://catalog.eol.ucar.edu/dc3_2011/research/chill/20110614/research.CHILL.201106140005.VEL.png',
  #   new OpenLayers.Bounds(-106.42, 39.0733, -102.675, 41.8267).transform(geoProj, mercProj),
  #   new OpenLayers.Size(1070,1020),
  #     isBaseLayer: false
  #     alwaysInRange: true
  # )
  # 
  # imageLayer5 = new OpenLayers.Layer.Image(
  #   'radar.NEXRAD.mosaic',
  #   'http://catalog.eol.ucar.edu//dc3_2011/radar/nexrad_mosaic/20110629/radar.NEXRAD_mosaic.201106292138.N0R_hires_radaronly.gif',
  #   new OpenLayers.Bounds(-127.620375523875420,21.652538062803,-66.517937876818,50.406626367301044).transform(geoProj, mercProj),
  #   new OpenLayers.Size(3400, 1600),
  #     isBaseLayer: false
  #     alwaysInRange: true
  # )
  # 
  # map.addLayers [imageLayer2, imageLayer3, imageLayer4, imageLayer5]
  # imageLayer2.setOpacity .5
  # imageLayer3.setOpacity .5
  # imageLayer4.setOpacity .5
  # imageLayer5.setOpacity .5


  return map


onFeatureSelect = (event) ->
  feature = event.feature
  console.log feature
  # console.log "featureselected"
  content = "<h2>" + feature.attributes.name + "</h2>" + feature.attributes.description

  console.log feature.attributes.description

  popup = new OpenLayers.Popup.FramedCloud "chickenXXX", 
    feature.geometry.getBounds().getCenterLonLat()
    new OpenLayers.Size(100,100)
    content
    null
    true #, onFeatureUnselect(event)

  feature.popup = popup
  CATMAP.map.addPopup popup

onFeatureUnselect = (event) ->
  # alert 'unselected'
  feature = event.feature
  console.log feature
  if feature.popup
    CATMAP.map.removePopup feature.popup
    feature.popup.destroy()
    delete feature.popup
