## -- coding: utf-8 --
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
<%inherit file="/base.mako" />

<%namespace name="maps" file="/maps.mako" />
<%def name="extra_head()">
      <% maps.extra_head() %>
</%def>
<%def name="body_property()">
      <% maps.body_property() %>
</%def>

<%def name="short_title()"><% return "Homepage" %></%def>

<%def name="feature()">
   <div id="skyline">
     <div id="skyline-inner">
       <div class="blurb"><span class="white">Linux.conf.au</span> is the premier <span class="light-orange">Linux</span> and <span class="light-orange">Open Source</span> conference in <span class="light-orange">Australasia</span> and it <span class="white">is coming</span> to Auckland</div>
       <div class="image-wrapper">
         <img src="/images/skyline-photo.png" />
       </div>
     </div>
     <div class="angle-edge"></div>
   </div>
</%def>

<section id="page-intro">
  <div class="section-content">
    <div class="row">
      <div class="main-content col-lg-8">
        <h2>Welcome to ${ h.lca_info['event_shortname'] } in ${ h.lca_info['event_city'] }!</h2>

        % if c.db_content is not None:
        ${ c.db_content.body | n }
        % else:
        <p>
          To put content here create a page with a URL of <u>/home</u> in the
          <a href="${ h.url_for(controller='db_content', action='new') }">page database</a>.
        </p>
        % endif
      </div>
      <div class="col-lg-4">
        <div id="days-left-section">
          <p>Sleeps until ${ h.lca_info['event_shortname'] }</p>
          <p><em>${ h.sleeps_till_conference() }</em></p>
        </div>
        % if not h.signed_in_person():
        <div class="account-buttons">
          <div class="button-area">
            <a href="/person/new" class="site-btn">Register</a>
          </div>
          <div class="button-area">
            <a href="/person/signin" class="site-btn-inverse">Signin</a>
          </div>
        </div>
        % endif
      </div>
    </div>
  </div>
</section>
<%include file="/latest_news.mako" />
<%include file="/sponsors_block.mako" args="tiered_sponsors=c.tiered_sponsors" />
<%include file="/location.mako" args="venue_photos=c.venue_photos, venue_text=c.venue_text" />
