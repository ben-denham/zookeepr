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

import sqlalchemy as sa
from meta import Base
from pylons.controllers.util import abort
from meta import Session

def setup(meta):
    pass

class Photo(Base):
    """Stores details of various site photos, such as venue photos.
    """
    __tablename__ = 'photo'

    base_image_path = '/images/photos/'

    id = sa.Column(sa.types.Integer, primary_key=True)
    name = sa.Column(sa.types.Text, nullable=False)
    description = sa.Column(sa.types.Text)
    image_path = sa.Column(sa.types.Text, nullable=False)
    gallery = sa.Column(sa.types.Text, nullable=False)
    weight = sa.Column(sa.types.Integer, nullable=False)

    @classmethod
    def find_all(cls):
        return Session.query(Photo).order_by(Photo.gallery, Photo.weight).all()

    @classmethod
    def find_all_by_gallery(cls, gallery):
        return Session.query(Photo).filter_by(gallery=gallery).order_by(
            Photo.weight).all()

    @classmethod
    def find_by_id(cls, id, abort_404 = False):
        result =  Session.query(Photo).filter_by(id=id).first()
        if result is None and abort_404:
            abort(404, "No such sponsor object")
        return result

    def get_path(self):

        return Photo.base_image_path + self.image_path
