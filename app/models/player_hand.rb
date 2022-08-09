class PlayerHand < ApplicationRecord
  belongs_to :hand
  belongs_to :user

  # TODO Criar validação pra não deixar salvar um registro repetido
  end
