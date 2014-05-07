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
<%
   footer_menu = h.footer_menu
   registration_menu = h.registration_menu
   contact_menu = h.contact_menu
%>

<footer class="footer" id="footer-bottom">  <div class="container">
    <div class="row">
      <div id="footer-menus">
        <div class="col-lg-2">
          <ul>
            % for (title, url) in footer_menu:
              <li><a href="${ url }">${ title }</a></li>
            % endfor
          </ul>
        </div>
        <div class="col-lg-2">
          <ul>
            <li><em class="bold-text uppercase">Register</em></li>
            % for (title, url) in registration_menu:
              <li><a href="${ url }">${ title }</a></li>
            % endfor
          </ul>
        </div>
        <div class="col-lg-2">
          <ul>
            <li><em class="bold-text uppercase">Get in touch</em></li>
            % for (title, url) in contact_menu:
              <li><a href="${ url }">${ title }</a></li>
            % endfor
          </ul>
        </div>
      </div>
      <div class="col-lg-6">
        <a href="/"><img src="/images/logo.png" alt="linux.conf.au 2015 logo" class="logo img-responsive"/>
      </div>
    </div>
  </div>
</footer>
