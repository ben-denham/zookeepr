<%inherit file="/base.mako" />
<h2>Coming soon!</h2>

<p>
The call for mini-confs is not yet open. Please visit back soon.
</p>

<p>
Return to the <a href="${ h.url_for("home") }">main page</a>.
</p>

<%def name="title()">
Call for Mini-confs - coming soon - ${ parent.title() }
</%def>
