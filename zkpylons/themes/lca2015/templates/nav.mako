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
   active_url = h.url_for()
   menu = h.lca_menu

   active_id = ''
   if active_url == '' or active_url == '/':
     active_id = 'home'

   for title, url, id in menu:
     if active_url.startswith(url):
       active_id = id

   # Get the class for an li element in the menu.
   def li_cls(id):
     if id == active_id:
       return 'class="active"'
     else:
       return 'class=""'

   # Get the class for an a element in the menu.
   def a_cls(id):
     if id == active_id:
       return 'class="active-link"'
     else:
       return 'class=""'
%>
<div class="navbar top-nav">
  <div class="container">
    <div class="account-buttons">
    % if h.signed_in_person():
      <div class="button-area">
        <a href="/dashboard" class="site-btn">Dashboard</a>
      </div>
      <div class="button-area">
        <a href="/person/signout" class="site-btn-inverse">Signout</a>
      </div>
    % else:
      <div class="button-area">
        <a href="/person/new" class="site-btn">Register</a>
      </div>
      <div class="button-area">
        <a href="/person/signin" class="site-btn-inverse">Signin</a>
      </div>
    % endif
    </div>
    <div class="navbar-header">
      <button type="button" class="navbar-toggle toggle-btn" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
    <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav navigation-list">
        % for (title, url, id) in menu:
          <li ${ li_cls(id) |n}><a href="${ url }" ${ a_cls(id) |n}>${ title }</a></li>
        % endfor
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</div>
