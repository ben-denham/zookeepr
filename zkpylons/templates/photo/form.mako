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
<fieldset>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="photo.name">Name:</label>
  </p>
  <p class="entries">
    ${ h.text('photo.name', size=60) }
  </p>

  <p class="label">
    <label for="photo.description">Description:</label>
  </p>
  <p class="entries">
    ${ h.textarea('photo.description') }
  </p>
  <ul class="note">
    <li>HTML is allowed.</li>
  </ul>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="photo.image_file">Image:</label>
  </p>
  <p class="entries">
    ${ h.file('photo.image_file') }
  </p>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="photo.gallery">Gallery:</label>
  </p>
  <p class="entries">
    ${ h.select('photo.gallery', h.photo_galleries[0], h.photo_galleries) }
  </p>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="photo.weight">Weight:</label>
  </p>
  <p class="entries">
    ${ h.text('photo.weight', size=20) }
  </p>

  <p>
    ${ h.submit("submit", "Save",) }
  </p>
</fieldset>
