// Generated by CoffeeScript 1.6.2
(function() {
  var CATMAP, onFeatureSelect, onFeatureUnselect;

  CATMAP = {};

  this.CATMAP = CATMAP;

  CATMAP.load_map = function(map_div_name) {
    var boulder, center, christchurch, color, colors, controls, geoProj, ghyb, gmap, gsat, gterr, kmlDir, layerSwitcher, map, mercProj, mtsat2kmCh1Layer, mtsatBounds, osm, salina, sas1kmCh1SeLayer, sas4kmCh1Layer, sas4kmCh3Layer, sas4kmCh4Layer, sas4kmGoesBounds, sasGoesSeBounds, styles;

    geoProj = new OpenLayers.Projection("EPSG:4326");
    mercProj = new OpenLayers.Projection("EPSG:900913");
    layerSwitcher = new OpenLayers.Control.LayerSwitcher;
    controls = [new OpenLayers.Control.KeyboardDefaults, new OpenLayers.Control.Graticule, layerSwitcher, new OpenLayers.Control.Navigation];
    map = new OpenLayers.Map(map_div_name, {
      controls: controls
    });
    layerSwitcher.maximizeControl();
    CATMAP.map = map;
    osm = new OpenLayers.Layer.OSM();
    map.addLayer(osm);
    gterr = new OpenLayers.Layer.Google("Google Terrain", {
      type: google.maps.MapTypeId.TERRAIN
    });
    gmap = new OpenLayers.Layer.Google("Google Streets", {
      numZoomLevels: 20
    });
    ghyb = new OpenLayers.Layer.Google("Google Hybrid", {
      type: google.maps.MapTypeId.HYBRID,
      numZoomLevels: 20
    });
    gsat = new OpenLayers.Layer.Google("Google Satellite", {
      type: google.maps.MapTypeId.SATELLITE,
      numZoomLevels: 22
    });
    map.addLayers([gterr, gmap, ghyb, gsat]);
    boulder = new OpenLayers.LonLat(-105.3, 40.028);
    salina = new OpenLayers.LonLat(-97.6459, 38.7871);
    christchurch = new OpenLayers.LonLat(172.620278, -43.53);
    center = christchurch;
    map.setCenter(center.transform(geoProj, mercProj), 5);
    colors = ['ff0000', '00ff00', '0000ff', 'ffd700', 'ff00ff', '00ffff'];
    styles = (function() {
      var _i, _len, _results;

      _results = [];
      for (_i = 0, _len = colors.length; _i < _len; _i++) {
        color = colors[_i];
        _results.push(new OpenLayers.Style({
          'strokeWidth': 3,
          'strokeColor': '#' + color
        }));
      }
      return _results;
    })();
    kmlDir = "kml";
    sas4kmGoesBounds = new OpenLayers.Bounds(-105.6473, 22.87, -65.46, 47.9302).transform(geoProj, mercProj);
    sas4kmCh1Layer = new OpenLayers.Layer.Image('ops.GOES-14.201305311645.4km_ch1_vis.jpg', 'img/ops.GOES-14.201305311645.4km_ch1_vis.jpg', sas4kmGoesBounds, new OpenLayers.Size(900, 700), {
      isBaseLayer: false,
      alwaysInRange: true
    });
    sas4kmCh3Layer = new OpenLayers.Layer.Image('ops.GOES-14.201305311645.4km_ch3_water_vapor.jpg', 'img/ops.GOES-14.201305311645.4km_ch3_water_vapor.jpg', sas4kmGoesBounds, new OpenLayers.Size(900, 700), {
      isBaseLayer: false,
      alwaysInRange: true
    });
    sas4kmCh4Layer = new OpenLayers.Layer.Image('ops.GOES-14.201305311645.4km_ch4_thermal-IR.jpg', 'img/ops.GOES-14.201305311645.4km_ch4_thermal-IR.jpg', sas4kmGoesBounds, new OpenLayers.Size(900, 700), {
      isBaseLayer: false,
      alwaysInRange: true
    });
    sasGoesSeBounds = new OpenLayers.Bounds(-93.1523, 28.09, -76.26, 41.876).transform(geoProj, mercProj);
    sas1kmCh1SeLayer = new OpenLayers.Layer.Image('ops.GOES-13.201306201740.1km_SE_ch1_vis.jpg', 'img/ops.GOES-13.201306201740.1km_SE_ch1_vis.jpg', sasGoesSeBounds, new OpenLayers.Size(1024, 1024), {
      isBaseLayer: false,
      alwaysInRange: true,
      wrapDateLine: true
    });
    map.addLayers([sas1kmCh1SeLayer]);
    sas1kmCh1SeLayer.setOpacity(.5);
    mtsatBounds = new OpenLayers.Bounds(161.0289, -46.54, 178.9711, -32.76).transform(geoProj, mercProj);
    mtsat2kmCh1Layer = new OpenLayers.Layer.Image('ops.MTSAT-2.201307242032.Hi-Res_ch1_vis.jpg', 'img/ops.MTSAT-2.201307242032.Hi-Res_ch1_vis.jpg', mtsatBounds, new OpenLayers.Size(2000, 2000), {
      isBaseLayer: false,
      alwaysInRange: true,
      wrapDateLine: true
    });
    map.addLayers([mtsat2kmCh1Layer]);
    mtsat2kmCh1Layer.setOpacity(.5);
    return map;
  };

  onFeatureSelect = function(event) {
    var content, feature, popup;

    feature = event.feature;
    console.log(feature);
    content = "<h2>" + feature.attributes.name + "</h2>" + feature.attributes.description;
    console.log(feature.attributes.description);
    popup = new OpenLayers.Popup.FramedCloud("chickenXXX", feature.geometry.getBounds().getCenterLonLat(), new OpenLayers.Size(100, 100), content, null, true);
    feature.popup = popup;
    return CATMAP.map.addPopup(popup);
  };

  onFeatureUnselect = function(event) {
    var feature;

    feature = event.feature;
    console.log(feature);
    if (feature.popup) {
      CATMAP.map.removePopup(feature.popup);
      feature.popup.destroy();
      return delete feature.popup;
    }
  };

}).call(this);
