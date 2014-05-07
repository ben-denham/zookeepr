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
<%page args="parent" />
<%def name="make_link(title, url)">
  <li><a href="${url}">${title}</a></li>
</%def>

% if h.auth.authorized(h.auth.has_organiser_role):
  <ul id="admin-toolbar" class="list-inline">
    ${ make_link('Admin', h.url_for(controller='admin')) }
    ${ make_link('Lookup', h.url_for(controller='admin', action='lookup')) }
    ${ make_link('View People', h.url_for(controller='person')) }
    ${ make_link('Manage Pages', h.url_for(controller='db_content')) }
    ${ make_link('Manage Files', h.url_for('/db_content/list_files')) }
    %  if c.db_content and not (h.url_for().endswith('/edit') or h.url_for().endswith('/new')):
    ${ make_link('Edit Page', h.url_for(controller='db_content', action='edit', id=c.db_content.id)) }
    %  elif c.not_found:
    ${ make_link('Create page here', h.url_for(controller='db_content', action='new')) }
    %  endif
    ${ parent.toolbox_extra_admin() }
  </ul>
% endif
