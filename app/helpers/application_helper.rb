module ApplicationHelper
    def get_or_create_player(username)
        name = clean_up_username(username)        
        player =  Player.find_by(username: name)
        
        if player.nil?
            player = Player.create!(username: name, email: "#{name.gsub(' ', '')}@email.com", password: '123456')
        end
        
        player
    end

    def cents_to_money(value_in_cents)
        number_to_currency(value_in_cents.to_f / 100)
    end

    private
    def clean_up_username(name)
      # retira os rebuys do nome
        if name.include?("[")
            name_array = name.split
            rebuy = name_array.last.gsub("[", "").gsub("]", "").to_i
            name_array.pop        
            name = name_array.join
        end
        name
    end
end
