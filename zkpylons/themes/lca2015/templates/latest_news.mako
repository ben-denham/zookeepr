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
<section id="news-section">
  <h1 class="section-heading"><span class="grey-line"></span><span class="title">News</span></h1>
  <div class="section-content">
    <div class="row">
      <div class="col-lg-8 col-md-8 news-item">
        %if len(c.db_content_news) > 0:
        <% news_item = c.db_content_news[0] %>
        <h3 class="news-title">${ h.link_to(news_item.title, url='/media/news/' + str(news_item.id)) }</h3>
        <div class="submitted">Posted on: ${ news_item.creation_timestamp.strftime("%Y-%m-%d") }</div>
        <div class="body">${ news_item.body |n }</div>
        %else:
        <p style="font-size: small;"><em>Currently no news...</em></p>
        %endif
      </div>
      <div class="col-lg-4 col-md-4 news-menu">
        <ul>
          % for (title, url) in h.news_menu:
          <li><a href="${ url }">${ title }</a></li>
          % endfor
        </ul>
      </div>
    </div>
  </div>
  <p class = 'more'><a href = '/media/news'>more news...</a></p>
</section>
