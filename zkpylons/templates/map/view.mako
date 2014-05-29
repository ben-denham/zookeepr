<%inherit file="/base.mako" />

<%namespace name="maps" file="/maps.mako" />
<%def name="extra_head()">
      <% maps.extra_head() %>
</%def>
<%def name="body_property()">
      <% maps.body_property() %>
</%def>

<h2>Venue Maps</h2>

% for map in h.lca_info['google_maps']:
    <div class="map-wrapper">
      <p>View this map on <a href="${ map['url'] }">Google Maps</a>, download the <a href="${ map['url'] }&output=kml">KML file</a>.</p>
      <div class="map_canvas" data-lat="${ map['lat'] }" data-lng="${ map['lng'] }" style="width:680px; height:500px"></div>
      % for marker in map['markers']:
        <div class="marker" data-lat="${ marker['lat'] }" data-lng="${ marker['lng'] }" data-label="${ marker['label'] }">
      % endfor
    </div>
% endfor
