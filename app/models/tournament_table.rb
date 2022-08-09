class TournamentTable < ApplicationRecord
  belongs_to :tournament
  belongs_to :table

  # TODO Criar validação pra não deixar salvar um registro repetido
end
