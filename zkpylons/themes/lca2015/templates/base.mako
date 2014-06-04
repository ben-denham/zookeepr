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
<%def name="title()">${ h.lca_info["event_byline"] }</%def>
<%def name="short_title()">
   ## Defined in children
</%def>
<%def name="extra_head()">
    ## Defined in children
</%def>
<%def name="extra_body()">
    ## Defined in children
</%def>
<%def name="body_property()"></%def>
<%def name="big_promotion()">
    ## Defined in children
</%def>
<%def name="toolbox_extra()">
    ## Defined in children
</%def>
<%def name="toolbox_extra_admin()">
    ## Defined in children
</%def>
<%def name="contents()">
    ## Defined in children
</%def>
<%def name="feature()">
    ## Defined in children
</%def>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${ self.title() }</title>
    <link rel="prefetch" href="https://login.persona.org/include.js">
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
    <link href="/media/news/rss" rel="alternate" type="application/rss+xml" title="${ h.lca_info['event_shortname'] } News">
    <!--[if IE 6]><link rel="stylesheet" href="ie6.css" type="text/css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" href="ie7.css" type="text/css" media="screen" /><![endif]-->

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" media="screen" href="/css/screen.css" type="text/css">
    <link rel="stylesheet" media="screen" href="/css/lightbox.css" type="text/css">
    <link rel="stylesheet" media="screen" href="/css/fonts.css" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    ${self.extra_head()}
  </head>
  <body ${ self.body_property() }>
    ${self.extra_body()}
    <%include file="toolbar.mako" args="parent=self" />
    <div id="wrap">
      <header id="header">
        <div class="container title">
          <div class="col-lg-5 logo-area col-md-5 col-sm-5 col-xs-12">
            <a href="/"><img src="/images/logo.png" alt="linux.conf.au 2015 logo" class="logo img-responsive"/>
            </a>
          </div>
          <div class="col-lg-7 site-heading col-md-7 col-sm-7 col-xs-12">
            <h2>12-16 January</h2>
          </div>
        </div>
        <%include file="/nav.mako" />
      </header>
      <main>
        ${ self.feature() }
        <div class="container">
          <%include file="/flash.mako" />
          % if h.signed_in_person():
            <%include file="/toolbox.mako" args="parent=self" />
          % endif
          ${ self.body() }
          <div id="up-button-area" class="col-lg-12">
            <div class="button-area">
              <button class="site-btn up-button" >
                <span>Back to the top</span>
              </button>
            </div>
          </div>
        </div><!-- /.container -->
      </main>
    </div><!-- /.wrap -->
    <%include file="/footer.mako" />
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script type="text/javascript" src="/jquery-1.7.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/google-analytics.js"></script>
    <script type="text/javascript">
      $(document).ready(function() {
      $('.up-button').click(function(){
      $("html, body").animate({scrollTop: 0}, 800);
      return false;
      });
      });
    </script>
  </body>
</html>
