import logging
import zkpylons.lib.helpers as h
from pylons import request, response, session, tmpl_context as c
from zkpylons.lib.helpers import redirect_to

from zkpylons.model import meta
from zkpylons.model.db_content import DbContent, DbContentType
from zkpylons.model.sponsor import Sponsor
from zkpylons.model.photo import Photo

from zkpylons.lib.base import BaseController, render


log = logging.getLogger(__name__)


class HomeController(BaseController):
    def index(self):
        """The home page of the website.

        If the user has not signed in, then they are presented with the
        default page.

        Otherwise, they're shown the customised page.

        We rely on `c.signed_in_person` containing the Person object for
        the currently signed in user, but we don't want to redirect to
        the signin action if we're not signed in so we duplicate the
        __before__ code from SecureController here.
        """

        if 'signed_in_person_id' in session:
            c.signed_in_person = self.dbsession.query(Person).filter_by(id=session['signed_in_person_id']).one()
        c.db_content = DbContent.find_by_url('/home', abort_404=False)

        c.tiered_sponsors = Sponsor.find_all_tiered()

        c.venue_photos = Photo.find_all_by_gallery("Venue")

        venue_text_url = '/venue'
        c.venue_text = DbContent.find_by_url(
            venue_text_url, abort_404=False).body
        if not c.venue_text:
            c.venue_text = 'To put content here create a page with a URL of '
            '<u>{venue_text_url}</u> in the <a href="{page_database_url}">page '
            'database</a>.'.format(
                venue_text_url = venue_text_url,
                page_database_url = h.url_for(
                    controller='db_content', action='new'))

        return render('/home.mako')
