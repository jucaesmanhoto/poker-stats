class TournamentStatsController < ApplicationController
  def index
    @spent = helpers.cents_to_money(total_buy_ins)
    @prizes =  helpers.cents_to_money(total_prizes)
    @roi = calculate_roi
  end

  def show
  end

  private
  def calculate_roi
    return ((total_prizes / total_buy_ins.to_f - 1) * 100).round(2)
  end

  def total_buy_ins
    tournament_buy_ins = current_user.tournaments.pluck(:buy_in_cents).reduce(:+)
    tournament_taxes = current_user.tournaments.pluck(:tax_cents).reduce(:+)
    tournament_buy_ins + tournament_taxes
  end

  def total_prizes
    current_user.prizes.pluck(:prize_cents).reduce(:+)
  end
end
