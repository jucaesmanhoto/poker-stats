class TableHand < ApplicationRecord
  belongs_to :table
  belongs_to :hand
  belongs_to :initial_bet_structure
end
