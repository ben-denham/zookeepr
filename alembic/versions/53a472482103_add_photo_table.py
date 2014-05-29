"""add photo table

Revision ID: 53a472482103
Revises: 3d148ab7ce43
Create Date: 2014-05-29 10:06:57.921626

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
