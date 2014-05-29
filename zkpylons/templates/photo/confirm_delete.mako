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
<h1>Delete Photo</h1>

${ h.form(h.url_for()) }
<p> Are you sure you want to delete the "${ c.photo.name }" photo (number
${c.photo.id})?</p>
<p>${ h.hidden('delete', 'ok') }
${ h.submit('Delete', 'Delete') }
${ h.end_form() } or ${ h.link_to('No, take me back.', url=h.url_for(action='index', id=None)) }</p>
