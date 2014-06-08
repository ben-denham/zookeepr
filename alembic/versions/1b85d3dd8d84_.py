"""
* This revision is a lie and should always be head

Revision ID: 1b85d3dd8d84
Revises: 53a472482103
Create Date: 2012-09-24 03:55:51.729799

"""
from zk import model
from zk.model import meta

# revision identifiers, used by Alembic.
revision = '1b85d3dd8d84'
down_revision = '53a472482103'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### initial database load ###
    engine = op.get_bind()
    model.init_model(engine)
    meta.Base.metadata.create_all(engine)
    model.setup(meta)
    ### end initial database load ###

def downgrade():
    pass
