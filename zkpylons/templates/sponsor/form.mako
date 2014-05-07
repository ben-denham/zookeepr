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
    <label for="sponsor.name">Name:</label>
  </p>
  <p class="entries">
    ${ h.text('sponsor.name', size=60) }
  </p>

  <p class="label">
    <label for="sponsor.url">URL:</label>
  </p>
  <p class="entries">
    ${ h.text('sponsor.url') }
  </p>

  <p class="label">
    <label for="sponsor.description">Description:</label>
  </p>
  <p class="entries">
    ${ h.textarea('sponsor.description') }
  </p>
  <ul class="note">
    <li>HTML is allowed.</li>
  </ul>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="sponsor.logo_file">Logo:</label>
  </p>
  <p class="entries">
    ${ h.file('sponsor.logo_file') }
  </p>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="sponsor.tier">Tier:</label>
  </p>
  <p class="entries">
    ${ h.select('sponsor.tier', h.sponsor_tiers[0], h.sponsor_tiers) }
  </p>

  <p class="label">
    <span class="mandatory">*</span>
    <label for="sponsor.weight">Weight:</label>
  </p>
  <p class="entries">
    ${ h.text('sponsor.weight', size=20) }
  </p>

  <p>
    ${ h.submit("submit", "Save",) }
  </p>
</fieldset>
