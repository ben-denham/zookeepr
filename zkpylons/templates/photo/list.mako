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
<h2>List of Photos</h2>

<table>
    <tr>
        <th>ID/Edit</th>
        <th>Name</th>
        <th>Image</th>
        <th>Gallery</th>
        <th>Weight</th>
        <th>Delete</th>
    </tr>

% for p in c.photo_collection:
    <tr class="${ h.cycle('even', 'odd')}">
        <td>${ h.link_to(str(p.id) + ' (edit)', url=h.url_for(controller='photo', action='edit', id=p.id)) }</td>
        <td>${ p.name }</td>
        <td><img src="${ p.get_path() }" /></td>
        <td>${ p.gallery }</td>
        <td>${ p.weight }</td>
        <td>${ h.link_to('X (delete)', url=h.url_for(controller='photo', action='delete', id=p.id)) }</td>
    </tr>
% endfor
</table>
<p>${ h.link_to('Add another', url=h.url_for(controller='photo', action='new')) }</p>

<%def name="title()">
List of Photos -
 ${ parent.title() }
</%def>
