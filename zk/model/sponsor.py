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
from zkpylons.lib.helpers import sponsor_tiers

def setup(meta):
    pass

class Sponsor(Base):
    """Stores details of conference sponsors
    """
    __tablename__ = 'sponsor'

    id = sa.Column(sa.types.Integer, primary_key=True)
    name = sa.Column(sa.types.Text, nullable=False)
    url = sa.Column(sa.types.Text)
    description = sa.Column(sa.types.Text)
    logo_path = sa.Column(sa.types.Text, nullable=False)
    tier = sa.Column(sa.types.Text, nullable=False)
    weight = sa.Column(sa.types.Integer, nullable=False)

    @classmethod
    def find_all(cls):
        return Session.query(Sponsor).order_by(Sponsor.tier, Sponsor.weight).all()

    @classmethod
    def find_all_tiered(cls):
        sponsors = Session.query(Sponsor).order_by(Sponsor.weight).all()
        tiers = {}
        for tier in sponsor_tiers:
            tiers[tier] = [sponsor for sponsor in sponsors
                           if sponsor.tier == tier]
        return tiers

    @classmethod
    def find_by_id(cls, id, abort_404 = False):
        result =  Session.query(Sponsor).filter_by(id=id).first()
        if result is None and abort_404:
            abort(404, "No such sponsor object")
        return result
