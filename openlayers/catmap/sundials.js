var lon = 5;
var lat = 40;
var zoom = 5;
var map, select;

function init(){
   map = new OpenLayers.Map('map');

   var wms = new OpenLayers.Layer.WMS(
       "OpenLayers WMS",
       "http://vmap0.tiles.osgeo.org/wms/vmap0",
       {layers: 'basic'}
   );

   var sundials = new OpenLayers.Layer.Vector("KML", {
       projection: map.displayProjection,
       strategies: [new OpenLayers.Strategy.Fixed()],
       protocol: new OpenLayers.Protocol.HTTP({
           url: "kml/sundials.kml",
           format: new OpenLayers.Format.KML({
               extractStyles: true,
               extractAttributes: true
           })
       })
   });
   
   map.addLayers([wms, sundials]);
   
   select = new OpenLayers.Control.SelectFeature(sundials);
   
   sundials.events.on({
       "featureselected": onFeatureSelect,
       "featureunselected": onFeatureUnselect
   });

   map.addControl(select);
   select.activate();   
   map.zoomToExtent(new OpenLayers.Bounds(68.774414,11.381836,123.662109,34.628906));
}
function onPopupClose(evt) {
   select.unselectAll();
}
function onFeatureSelect(event) {
   var feature = event.feature;
   // Since KML is user-generated, do naive protection against
   // Javascript.
   var content = "<h2>"+feature.attributes.name + "</h2>" + feature.attributes.description;
   if (content.search("<script") != -1) {
       content = "Content contained Javascript! Escaped content below.<br>" + content.replace(/</g, "&lt;");
   }
   popup = new OpenLayers.Popup.FramedCloud("chicken", 
                            feature.geometry.getBounds().getCenterLonLat(),
                            new OpenLayers.Size(100,100),
                            content,
                            null, true, onPopupClose);
   feature.popup = popup;
   map.addPopup(popup);
}
function onFeatureUnselect(event) {
   var feature = event.feature;
   if(feature.popup) {
       map.removePopup(feature.popup);
       feature.popup.destroy();
       delete feature.popup;
   }
}
