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
<%page args="tiered_sponsors" />
<%def name="become_a_sponsor()">
<a class="become-a-sponsor" href="/become-a-sponsor">Become a Sponsor</a>
</%def>
<%def name="column(index, sponsor)">
<div class="col-lg-3 col-md-3 col-sm-6 sponsor-col sponsor-row-index-${ index }">
  <div class="col-inner">
    <div class="col-center">
      % if sponsor != None:
      % if hasattr(sponsor, 'url'):
      <a href="${ sponsor.url }">
      % endif
      <img src="/images/sponsors/${ sponsor.logo_path }" />
      % if hasattr(sponsor, 'url'):
      </a>
      % endif
      % else:
      ${ become_a_sponsor() }
      % endif
    </div>
  </div>
</div>
</%def>
<%def name="rows(sponsors)">
<% row_length = 4 %>
% for i in xrange(0, len(sponsors), row_length):
<%
   row_sponsors = sponsors[i:i+row_length]
   empty_cols = row_length - len(row_sponsors)
   row_sponsors.extend([None] * empty_cols)
   %>
<div class="row empty-${ empty_cols }">
  % for index, sponsor in enumerate(row_sponsors):
  ${ column(index, sponsor) }
  % endfor
</div>
% endfor
</%def>
<section id="sponsors-section">
  <h1 class="section-heading"><span class="grey-line"></span><span class="title">Sponsors</span></h1>
  % for tier, sponsors in tiered_sponsors.iteritems():
  <div class="sponsor-division">
    % if sponsors:
    <span class="become-sponsor-right">${ become_a_sponsor() }</span>
    <h2>${ tier } Sponsors</h2>
    <div class="section-content">
      ${ rows(sponsors) }
    </div>
    % endif
  </div>
  % endfor
</section>
