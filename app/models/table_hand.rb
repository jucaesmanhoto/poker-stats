class TableHand < ApplicationRecord
  belongs_to :table
  belongs_to :hand
  belongs_to :initial_bet_structure

  # TODO Criar validação pra não deixar salvar um registro repetido
end
