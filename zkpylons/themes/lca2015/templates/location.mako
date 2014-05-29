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

<%page args="venue_photos, venue_text" />

<section id="location-section">
  <h1 class="section-heading"><span class="grey-line"></span><span class="title">Location</span></h1>
  <h2>The Venue</h2>
  <div class="section-content">
    <div class="row">
	  <div class="col-lg-6 col-md-6" >
	    <p>
              ${ venue_text | n }
	    </p>
	  </div>
	  <div class="col-lg-6 col-md-6 venue-photos" >
	    <% even = False %>
	    % for photo in venue_photos:
	      <div class="image-box ${ 'even' if even else 'odd' }">
		<img src="${ photo.get_path() }" />
	      </div>
	      <% even = not even %>
            % endfor
	  </div>
    </div>
  </div>
  <h2>Maps</h2>
  <div class="section-content" id="map-section-content">
    <div class="row">
      % for map in h.lca_info['google_maps']:
	  <div class="col-lg-6" >
	    <div class="image-box">
              <div class="map_canvas" data-lat="${ map['lat'] }" data-lng="${ map['lng'] }" style="width:100%; height: 0; padding-bottom: 100%;">
	      </div>
	      % for marker in map['markers']:
		    <div class="marker" data-lat="${ marker['lat'] }" data-lng="${ marker['lng'] }" data-label="${ marker['label'] }">
	      % endfor
            </div>
	  </div>
      % endfor
    </div>
  </div>
</section>
