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
<div id="flash">
  <% messages = h.get_flashes() %>
  %if messages:
  %   for (category, msgs) in messages.iteritems():
  <div class="alerts">
      %          for msg in msgs:
      <div class="alert alert-${ h.computer_title(category) }">
        ${ msg | n }
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      %          endfor
  </div>
  %   endfor
  %endif
  %if c.form_errors:
  <div class="alerts">
      %       for field in c.form_errors:
      <div class="alert alert-error">
        ## To provide pretty field names pass them in via c.form_fields. 
        %  if field in c.form_fields:
        ${ c.form_fields[field] }
        %  else:
        ${ field }
        %endif
        : ${ c.form_errors[field] | n }
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      %       endfor
  </div>
  %endif
</div>
