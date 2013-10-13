"""empty message

Revision ID: 314a25616398
Revises: 4bc542221a52
Create Date: 2013-10-13 00:14:37.694299

"""

# revision identifiers, used by Alembic.
revision = '314a25616398'
down_revision = '4bc542221a52'

from alembic import op
import sqlalchemy as sa

def upgrade():
    op.create_unique_constraint(
        name='transaction_splits_tran_acc_uix',
        source='transaction_splits',
        local_cols=['transaction_id', 'account_id',],
    )

def downgrade():
    op.drop_constraint(
        name='transaction_splits_tran_acc_uix',
        table_name='transaction_splits',
    )
