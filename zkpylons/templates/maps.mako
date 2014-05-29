<%doc>
Zookeepr: Conference Management System http://zookeepr.org
Copyright (C) 2014 Catalyst IT Ltd

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
</%doc>

<%def name="extra_head()">

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript" src="/js/geoxml3.js"></script>
<script type="text/javascript">
function detectBrowser() {
  var useragent = navigator.userAgent;
  var mapdiv = document.getElementById("map_canvas");

  if (useragent.indexOf('iPhone') != -1 || useragent.indexOf('Android') != -1 ) {
    mapdiv.style.width = '100%';
    mapdiv.style.height = '100%';
  } else {
    mapdiv.style.width = '600px';
    mapdiv.style.height = '800px';
  }
}
function map_load() {
    $('.map_canvas').each(function() {
	var myLatlng = new google.maps.LatLng($(this).attr('data-lat'), $(this).attr('data-lng'));
	var myOptions = {
	    zoom: 11,
	    center: myLatlng,
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	var myMap = new google.maps.Map(this, myOptions);

	$(this).siblings('.marker').each(function() {
	    new google.maps.Marker({
		map: myMap,
		animation: google.maps.Animation.DROP,
		position: new google.maps.LatLng($(this).attr('data-lat'), $(this).attr('data-lng')),
		title: $(this).attr('data-label')
	    })
	})

	var myParser = new geoXML3.parser({map: myMap});
	myParser.parse("/map.kml");
    })
}
</script>
</%def>

<%def name="body_property()">onload="map_load()"</%def>
