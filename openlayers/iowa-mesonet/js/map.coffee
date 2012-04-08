load_map = (div_name)->

  # avoid pink error tiles
  OpenLayers.IMAGE_RELOAD_ATTEMPTS = 4;
  OpenLayers.Util.onImageLoadErrorColor = "transparent";

  map = new OpenLayers.Map div_name
  ol_wms = new OpenLayers.Layer.WMS "OpenLayers WMS", "http://vmap0.tiles.osgeo.org/wms/vmap0?",
      layers: "basic"

  map.addLayer ol_wms

  ames = new OpenLayers.LonLat -93.62, 42.034722

  map.setCenter ames, 5

  # map.zoomToExtent(new OpenLayers.Bounds(-100.898437,22.148438,-78.398437,39.726563));
  # map.zoomToExtent( new OpenLayers.Bounds(-110,20,-100,40) )

  # east_ir_4km
  GOESEASTIR = 
    layer: 'east_ir_4km'
    url:   'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/east_ir.cgi?'
    visibility: true

  GOESWESTIR = 
    layer: 'west_ir_4km'
    url:   'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/west_ir.cgi?'

  GOESCONUSIR = 
    layer: 'goes_conus_ir'
    url:   'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/conus_ir.cgi?'

  NEXRADBASEREFLECT=
    layer: "nexrad_base_reflect"
    url:   "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0q.cgi?"
    visibility: true

  NEXRADN0Q=
    layer: "nexrad-n0q"
    url:   "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0q.cgi?"
    visibility: true

  iowa_cgis = [ GOESEASTIR, GOESWESTIR, NEXRADBASEREFLECT, NEXRADN0Q ]
  # iowa_cgis=[]
  for iowa_cgi in iowa_cgis
    # iowa_wms_layer = new OpenLayers.Layer.WMS "Nexrad", "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r-t.cgi?",
    iowa_wms_layer = new OpenLayers.Layer.WMS iowa_cgi['layer'], iowa_cgi['url'],
        layers: iowa_cgi['layer']
        transparent: true
        format: "image/png"
        # time: "2005-08-29T13:00:00Z"
    iowa_wms_layer.setOpacity .6
    iowa_wms_layer.setVisibility (iowa_cgi['visibility']? and iowa_cgi['visibility'])
  
    map.addLayer iowa_wms_layer

  layerSwitcher = new OpenLayers.Control.LayerSwitcher({'ascending':false})
  map.addControl layerSwitcher
  layerSwitcher.maximizeControl()

$ ->
  load_map('map')
