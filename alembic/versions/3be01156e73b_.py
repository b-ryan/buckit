"""Third

Revision ID: 3be01156e73b
Revises: 314a25616398
Create Date: 2013-10-19 11:47:10.819283

"""

# revision identifiers, used by Alembic.
revision = '3be01156e73b'
down_revision = '314a25616398'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('transaction_splits', 'account_id',
               existing_type=sa.INTEGER(),
               nullable=False)
    op.alter_column('transaction_splits', 'transaction_id',
               existing_type=sa.INTEGER(),
               nullable=False)
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.alter_column('transaction_splits', 'transaction_id',
               existing_type=sa.INTEGER(),
               nullable=True)
    op.alter_column('transaction_splits', 'account_id',
               existing_type=sa.INTEGER(),
               nullable=True)
    ### end Alembic commands ###
