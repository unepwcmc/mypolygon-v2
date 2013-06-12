// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jQuery.XDomainRequest
//= require leaflet
//= require leaflet.draw
//= require pica
//= require underscore-min
//= require json2
//= require backbone-min
//= require diorama/diorama_managed_region
//= require diorama/diorama_controller
//= require spin
//= require main
//= require_tree .


// console is undefined error for internet explorer
if (!window.console) console = {log: function() {}};

// TODO: these should not be a global, but effectively it is!
var roundToDecimals = function(number, places) {
    places = Math.pow(10, places);
    return Math.round(number * places) / places;
};

var addCommasToNumber = function(number) {
  value = "" + number;

  if (!/^[0-9]+$/.test(value)) { return value; }

  value = value.split("").reverse();

  // http://stackoverflow.com/a/7125034
  var comma_value = "";
  var i = 0;
  for ( i = 0; i <= value.length-1; i = i + 1 ){
    comma_value = value[i] + comma_value;
    if ((i+1) % 3 === 0 && (value.length-1) !== i) {
      comma_value = ',' + comma_value;
    }
  }

  return comma_value;
};
