class HandsController < ApplicationController


  REGEX_HAND_HISTORY = {
    hand_number: /PokerStars Hand #(?<hand_number>\d*):\s*Tournament\s*#(?<tournament_number>\d*),\s*\$(?<buy_in>\d*\.\d{2})\+\$(?<tax>\d*\.\d{2}).*Level (?<level>\w*) \((?<small_blind>\d*)\/(?<big_blind>\d*)\)\s-\s(?<y>\d{4})\/(?<M>\d{2})\/(?<d>\d{2}) (?<h>\d{2}):(?<m>\d{2}):(?<s>\d{2})/i,
    table_number: /Table\s*'(?<table_number>\d*\s\d*)'\s*(?<max_seats>\d)-max Seat #(?<button_seat>\d) is the button/i,
    hole_cards: /Dealt to.*\[(?<first_card>\d|\w{2,3})\s(?<second_card>\d|\w{2,3})\]/i,
    table_set_up: /Seat (?<seat_number>\d*)\:\s(?<player_username>.*)\s\((?<chips>\d*)\s/i,
  }

  LEVELS = {
    I: 1,
    II: 2,
    III: 3,
    IV: 4,
    V: 5,
    VI: 6,
    VII: 7,
    VII: 8,
    IX: 9,
    X: 10,
  }


  def new
    @hand = Hand.new
    @hands = []
  end

  def create
    path = "lib/assets/HH20220725.txt"
    @tournament = nil
    table = nil
    initial_bet_structure = nil
    hand = nil
    
    File.open(path).each do |line|
      REGEX_HAND_HISTORY.each do |key, regexp|
        match = line.match(regexp)
        
        if match && key == :hand_number
          hand = get_or_create_hand(match)
          tournament = get_or_create_tournament(match)
          initial_bet_structure = InitialBetStructure.create!(
            big_blind: match[:big_blind],
            small_blind: match[:small_blind],
            level: LEVELS[match[:level].to_sym]
          )
        end

        if match && key == :table_number
          table = get_or_create_table(match)
          tournament_table = TournamentTable.create!(
            tournament: tournament,
            table: table
          )

          hand.save
          
          table_hand = TableHand.find_by(hand: hand, table: table, initial_bet_structure: initial_bet_structure)
          if table_hand.nil?
            TableHand.create!(
              hand: hand, 
              table: table, 
              initial_bet_structure: initial_bet_structure
            )
          end
        end

        if match && key == :table_set_up
          player = helpers.get_or_create_player(match[:player_username])
          PlayerHand.create!(
            user: player,
            hand: hand,
            seat_number: match[:seat_number].to_i  
          )
        end

        if match && key == :hole_cards
          player_hand = get_or_create_player_hand(current_user.username, hand)
          
          player_hand.first_pocket_card = match[:first_card]
          player_hand.second_pocket_card = match[:second_card]

          player_hand.save!
        end
      end
    end
  end

  def parse_hole_cards(lines)
    lines.each do |line|
      match = line.match(REGEX_HAND_HISTORY[:hole_cards])
      if !current_user || (match && match[:player_username] != current_user.username)
        # TODO TROW AN ERROR
        puts "You're not allowed to upload this file"
        raise
      end

      if match
        PlayerHand.create(
          hand: @hand, 
          user: current_user, 
          first_pocket_card: match[:first_card],
          second_pocket_card: match[:second_card]
        )
      end
    end
  end

  def parse_setup(lines)
    lines.each do |line|
      SETUP_REGEX.each do |key, regexp|
        match = line.match(regexp)
        if match && key == :hand_number
          @hand = get_or_create_hand(match)
          @tournament = get_or_create_tournament(match)
          @initial_bet_structure = get_or_create_initial_bet_structure(match)
        end

        if match && key == :table_number
          table = get_or_create_table(match)
          @hand.save
          table_hand = TableHand.find_by(hand: @hand, table: table, initial_bet_structure: @initial_bet_structure)
          if table_hand.nil?
            TableHand.create(hand: @hand, table: table, initial_bet_structure: @initial_bet_structure)
          end
        end

      end
    end
  end

  def separate_by_section(lines)
    sections = {setup: []}
    new_section = false
    new_section_name = ''
    lines.each do |line|
      if line.start_with?('*')
        new_section = true
        new_section_name = line.match(REGEX_HAND_HISTORY[:section_name])[:section_name].to_sym
        sections[new_section_name] = []
      end
      if new_section
        sections[new_section_name] << line
      else
        sections[:setup] << line
      end
    end
    sections
  end

  def get_lines_per_hand(path)
    hand_lines = []
    hands = []
    should_insert = false
    empty_lines_counter = 0
    File.open(path).each do |line|
      should_insert = true if line.match(REGEX_HAND_HISTORY[:hand_number])
      hand_lines << line if should_insert
      if line == "\r\n"
        empty_lines_counter += 1
        should_insert = false
      end
      if empty_lines_counter == 3
        hands << hand_lines
        hand_lines = []
        empty_lines_counter = 0
      end
    end
    hands
  end
  
  def get_or_create_player_hand(username, hand)
    player_hand = PlayerHand.find_by(user: helpers.get_or_create_player(username), hand: hand)
    if player_hand.nil?
      player_hand = PlayerHand.create()
    end
    player_hand
  end
  
  def get_or_create_hand(match)
    hand = Hand.find_by(number: match[:hand_number])
    if hand.nil?
      hand = Hand.create(number: match[:hand_number])
    end
    hand
  end

  def get_or_create_table(match)
    table = Table.find_by(number: match[:table_number])
    if table.nil?
      table = Table.create(
        number: match[:table_number],
        number_of_seats: match[:max_seats],
      )
    end
    table
  end

  def get_or_create_tournament(match)
    tournament = Tournament.find_by(number: match[:tournament_number])
    if tournament.nil?
      tournament = Tournament.create!(
        number: match[:tournament_number],
        buy_in_cents: match[:buy_in].to_i,
        tax_cents: match[:tax].to_i,
        started_at: DateTime.new(
          match[:y].to_i, 
          match[:M].to_i, 
          match[:d].to_i, 
          match[:h].to_i, 
          match[:m].to_i, 
          match[:s].to_i
        ),
      )
    end
    tournament
  end

  def get_or_create_initial_bet_structure(match)
    initial_bet_structure = InitialBetStructure.find_by(
      big_blind: match[:big_blind],
      small_blind: match[:small_blind],
      level: LEVELS[match[:level].to_sym]
    )
    if initial_bet_structure.nil?
      initial_bet_structure = InitialBetStructure.create(
        big_blind: match[:big_blind],
        small_blind: match[:small_blind],
        level: LEVELS[match[:level].to_sym]
      )
    end
    initial_bet_structure
  end
end
