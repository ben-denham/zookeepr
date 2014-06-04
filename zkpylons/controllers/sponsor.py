"""
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
"""

from pylons import url, request, tmpl_context as c
from pylons.controllers.util import redirect
import zkpylons.lib.helpers as h
from zkpylons.lib.helpers import redirect_to
from zkpylons.model.sponsor import Sponsor
from zkpylons.model import meta
from zkpylons.lib.validators import BaseSchema, ImageUploadValidator
from zkpylons.lib.base import BaseController, render
from zkpylons.config.zkpylons_config import file_paths
from formencode import validators, htmlfill
from formencode.variabledecode import NestedVariables
from authkit.authorize.pylons_adaptors import authorize
from pylons.decorators import validate
from pylons.decorators.rest import dispatch_on
import os

class SponsorSchema(BaseSchema):
    name = validators.String(not_empty=True)
    url = validators.String()
    description = validators.String()
    logo_file = ImageUploadValidator(unique=True)
    tier = validators.OneOf(h.sponsor_tiers, not_empty=True)
    weight = validators.Int()

class NewSponsorSchema(BaseSchema):
    sponsor = SponsorSchema()
    pre_validators = [NestedVariables]

class UpdateSponsorSchema(BaseSchema):
    sponsor = SponsorSchema()
    pre_validators = [NestedVariables]

class SponsorController(BaseController):

    sponsor_logos_directory = file_paths['public_path'] + Sponsor.image_path

    # Returns the saved filename.
    def _save_logo(self, file):
        if not os.path.exists(self.sponsor_logos_directory):
            os.makedirs(self.sponsor_logos_directory)

        orig_filename, file_ext = os.path.splitext(file.filename)
        filename = orig_filename + file_ext
        index = 0
        while os.path.exists(self.sponsor_logos_directory + filename):
            index += 1
            filename = orig_filename + ' (' + str(index) + ')' + file_ext

        fp = open(self.sponsor_logos_directory + filename,'wb')
        fp.write(file.value)
        file.file.close()
        fp.close()
        return filename

    def _delete_logo(self, filename):
        try:
            os.remove(self.sponsor_logos_directory + filename)
        except Exception:
            pass

    def index(self):
        c.sponsor_collection = Sponsor.find_all()
        return render('/sponsor/list.mako')

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_new")
    def new(self):
        c.sponsor = Sponsor()
        defaults = h.object_to_defaults(c.sponsor, 'sponsor')
        form = render('/sponsor/new.mako')
        return htmlfill.render(form, defaults)

    @authorize(h.auth.has_organiser_role)
    @validate(schema=NewSponsorSchema(), form='new', post_only=True,
              on_get=True, variable_decode=True)
    def _new(self):
        results = self.form_result['sponsor']
        results['logo_path'] = self._save_logo(results['logo_file'])
        del results['logo_file']

        c.sponsor = Sponsor(**results)
        meta.Session.add(c.sponsor)
        meta.Session.commit()

        h.flash("New Sponsor Created.")
        redirect(url(controller='sponsor', action='index'))

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_edit")
    def edit(self, id):
        c.sponsor = Sponsor.find_by_id(id)

        defaults = h.object_to_defaults(c.sponsor, 'sponsor')

        form = render('/sponsor/edit.mako')
        return htmlfill.render(form, defaults)

    @authorize(h.auth.has_organiser_role)
    @validate(schema=UpdateSponsorSchema(), form='edit', post_only=True,
              on_get=True, variable_decode=True)
    def _edit(self, id):
        c.sponsor = Sponsor.find_by_id(id)
        results = self.form_result['sponsor']

        if hasattr(results['logo_file'], 'value'):
            self._delete_logo(c.sponsor.logo_path)
            results['logo_path'] = self._save_logo(results['logo_file'])
        del results['logo_file']

        for key in self.form_result['sponsor']:
            setattr(c.sponsor, key, results[key])

        # update the objects with the validated form data
        meta.Session.commit()
        h.flash("Sponsor updated.")
        redirect(url(controller='sponsor', action='index'))

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_delete")
    def delete(self, id):
        c.sponsor = Sponsor.find_by_id(id)
        return render('/sponsor/confirm_delete.mako')

    @authorize(h.auth.has_organiser_role)
    @validate(schema=None, form='delete', post_only=True, on_get=True,
              variable_decode=True)
    def _delete(self, id):
        c.sponsor = Sponsor.find_by_id(id)
        self._delete_logo(c.sponsor.logo_path)
        meta.Session.delete(c.sponsor)
        meta.Session.commit()

        h.flash("Sponsor Deleted.")
        redirect(url(controller='sponsor', action='index'))
