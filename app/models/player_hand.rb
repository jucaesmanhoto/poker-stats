class PlayerHand < ApplicationRecord
  belongs_to :hand
  belongs_to :user

  validates :first_pocket_card, :second_pocket_card, presence: true
  # TODO Criar validação pra não deixar salvar um registro repetido
  end
