"""add photo table

Revision ID: 53a472482103
Revises: 3d148ab7ce43
Create Date: 2014-05-29 10:06:57.921626

"""

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

# revision identifiers, used by Alembic.
revision = '53a472482103'
down_revision = '3d148ab7ce43'

from alembic import op
import sqlalchemy as sa


def upgrade():
    op.create_table('photo',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.Text(), nullable=False),
    sa.Column('description', sa.Text(), nullable=False),
    sa.Column('image_path', sa.Text(), nullable=False),
    sa.Column('gallery', sa.Text(), nullable=False),
    sa.Column('weight', sa.Integer(), nullable=False),
    sa.PrimaryKeyConstraint('id'),
    )
    pass


def downgrade():
    op.drop_table('photo')
    pass
