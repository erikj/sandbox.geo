(function() {
  var load_map;

  load_map = function(div_name) {
    var GOESCONUSIR, GOESEASTIR, GOESWESTIR, NEXRADBASEREFLECT, NEXRADN0Q, ames, iowa_cgi, iowa_cgis, iowa_wms_layer, keyboardControl, layerSwitcher, map, osm, panZoomBar, _i, _len;
    OpenLayers.IMAGE_RELOAD_ATTEMPTS = 4;
    OpenLayers.Util.onImageLoadErrorColor = "transparent";
    map = new OpenLayers.Map({
      div: div_name,
      projection: new OpenLayers.Projection("EPSG:900913"),
      units: "m",
      maxResolution: 156543.0339,
      maxExtent: new OpenLayers.Bounds(-20037508, -20037508, 20037508, 20037508.34),
      controls: [],
      fractionalZoom: true
    });
    osm = new OpenLayers.Layer.OSM('open street map', null, {
      resolutions: [156543.03390625, 78271.516953125, 39135.7584765625, 19567.87923828125, 9783.939619140625, 4891.9698095703125, 2445.9849047851562, 1222.9924523925781, 611.4962261962891, 305.74811309814453, 152.87405654907226, 76.43702827453613, 38.218514137268066, 19.109257068634033, 9.554628534317017, 4.777314267158508, 2.388657133579254, 1.194328566789627, 0.5971642833948135],
      serverResolutions: [156543.03390625, 78271.516953125, 39135.7584765625, 19567.87923828125, 9783.939619140625, 4891.9698095703125, 2445.9849047851562, 1222.9924523925781, 611.4962261962891, 305.74811309814453, 152.87405654907226, 76.43702827453613, 38.218514137268066, 19.109257068634033, 9.554628534317017, 4.777314267158508, 2.388657133579254, 1.194328566789627, 0.5971642833948135],
      transitionEffect: 'resize'
    });
    map.addLayer(osm);
    ames = new OpenLayers.LonLat(-93.62, 42.034722);
    map.setCenter(ames.transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject()), 5);
    GOESEASTIR = {
      layer: 'east_ir_4km',
      url: 'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/east_ir.cgi?',
      visibility: true
    };
    GOESWESTIR = {
      layer: 'west_ir_4km',
      url: 'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/west_ir.cgi?'
    };
    GOESCONUSIR = {
      layer: 'goes_conus_ir',
      url: 'http://mesonet.agron.iastate.edu/cgi-bin/wms/goes/conus_ir.cgi?'
    };
    NEXRADBASEREFLECT = {
      layer: "nexrad_base_reflect",
      url: "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0q.cgi?",
      visibility: true
    };
    NEXRADN0Q = {
      layer: "nexrad-n0q",
      url: "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0q.cgi?",
      visibility: true
    };
    iowa_cgis = [GOESEASTIR, GOESWESTIR, NEXRADBASEREFLECT, NEXRADN0Q];
    for (_i = 0, _len = iowa_cgis.length; _i < _len; _i++) {
      iowa_cgi = iowa_cgis[_i];
      iowa_wms_layer = new OpenLayers.Layer.WMS(iowa_cgi['layer'], iowa_cgi['url'], {
        layers: iowa_cgi['layer'],
        transparent: true,
        format: "image/png"
      }, {
        transitionEffect: 'resize'
      });
      iowa_wms_layer.setOpacity(.6);
      iowa_wms_layer.setVisibility((iowa_cgi['visibility'] != null) && iowa_cgi['visibility']);
      map.addLayer(iowa_wms_layer);
    }
    keyboardControl = new OpenLayers.Control.KeyboardDefaults;
    layerSwitcher = new OpenLayers.Control.LayerSwitcher({
      'ascending': false
    });
    panZoomBar = new OpenLayers.Control.PanZoomBar;
    map.addControls([layerSwitcher, keyboardControl, panZoomBar]);
    return layerSwitcher.maximizeControl();
  };

  $(function() {
    return load_map('map');
  });

}).call(this);
