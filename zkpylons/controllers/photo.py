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
from zkpylons.model.photo import Photo
from zkpylons.model import meta
from zkpylons.lib.validators import BaseSchema
from zkpylons.lib.base import BaseController, render
from zkpylons.config.zkpylons_config import file_paths
from formencode import validators, htmlfill
from formencode.variabledecode import NestedVariables
from authkit.authorize.pylons_adaptors import authorize
from pylons.decorators import validate
from pylons.decorators.rest import dispatch_on
import os

class PhotoSchema(BaseSchema):
    name = validators.String(not_empty=True)
    description = validators.String()
    image_file = validators.FieldStorageUploadConverter(unique=True)
    gallery = validators.OneOf(h.photo_galleries, not_empty=True)
    weight = validators.Int()

class NewPhotoSchema(BaseSchema):
    photo = PhotoSchema()
    pre_validators = [NestedVariables]

class UpdatePhotoSchema(BaseSchema):
    photo = PhotoSchema()
    pre_validators = [NestedVariables]

class PhotoController(BaseController):

    photos_directory = file_paths['public_path'] + Photo.base_image_path

    # Returns the saved filename.
    def _save_image(self, file):
        if not os.path.exists(self.photos_directory):
            os.makedirs(self.photos_directory)

        orig_filename, file_ext = os.path.splitext(file.filename)
        filename = orig_filename + file_ext
        index = 0
        while os.path.exists(self.photos_directory + filename):
            index += 1
            filename = orig_filename + ' (' + str(index) + ')' + file_ext

        fp = open(self.photos_directory + filename,'wb')
        fp.write(file.value)
        file.file.close()
        fp.close()
        return filename

    def _delete_image(self, filename):
        try:
            os.remove(self.photos_directory + filename)
        except Exception:
            pass

    def index(self):
        c.photo_collection = Photo.find_all()
        return render('/photo/list.mako')

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_new")
    def new(self):
        c.photo = Photo()
        defaults = h.object_to_defaults(c.photo, 'photo')
        form = render('/photo/new.mako')
        return htmlfill.render(form, defaults)

    @authorize(h.auth.has_organiser_role)
    @validate(schema=NewPhotoSchema(), form='new', post_only=True,
              on_get=True, variable_decode=True)
    def _new(self):
        results = self.form_result['photo']
        results['image_path'] = self._save_image(results['image_file'])
        del results['image_file']

        c.photo = Photo(**results)
        meta.Session.add(c.photo)
        meta.Session.commit()

        h.flash("New Photo Created.")
        redirect(url(controller='photo', action='index'))

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_edit")
    def edit(self, id):
        c.photo = Photo.find_by_id(id)

        defaults = h.object_to_defaults(c.photo, 'photo')

        form = render('/photo/edit.mako')
        return htmlfill.render(form, defaults)

    @authorize(h.auth.has_organiser_role)
    @validate(schema=UpdatePhotoSchema(), form='edit', post_only=True,
              on_get=True, variable_decode=True)
    def _edit(self, id):
        c.photo = Photo.find_by_id(id)
        results = self.form_result['photo']

        if hasattr(results['image_file'], 'value'):
            self._delete_image(c.photo.image_path)
            results['image_path'] = self._save_image(results['image_file'])
        del results['image_file']

        for key in self.form_result['photo']:
            setattr(c.photo, key, results[key])

        # update the objects with the validated form data
        meta.Session.commit()
        h.flash("Photo updated.")
        redirect(url(controller='photo', action='index'))

    @authorize(h.auth.has_organiser_role)
    @dispatch_on(POST="_delete")
    def delete(self, id):
        c.photo = Photo.find_by_id(id)
        return render('/photo/confirm_delete.mako')

    @authorize(h.auth.has_organiser_role)
    @validate(schema=None, form='delete', post_only=True, on_get=True,
              variable_decode=True)
    def _delete(self, id):
        c.photo = Photo.find_by_id(id)
        self._delete_image(c.photo.image_path)
        meta.Session.delete(c.photo)
        meta.Session.commit()

        h.flash("Photo Deleted.")
        redirect(url(controller='photo', action='index'))
