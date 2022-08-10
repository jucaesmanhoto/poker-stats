class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tournament_players
  has_many :tournaments, through: :tournament_players
  has_many :prizes, through: :tournament_players

  validates :email, :username, uniqueness: true
end

Player = User