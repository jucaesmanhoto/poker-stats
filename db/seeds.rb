# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Starting the seeds.rb file..."

puts "Erasing all users from database"
Player.delete_all

puts "Creating the players..."
players = %w[JSE78 deni.dxc]
players.each do |player| 
    is_admin = player == players.first
    Player.create!(
        username: player, 
        email: "#{player.downcase}@email.com", 
        password:  "123456",
        admin: is_admin
    )
    puts "player #{player} created#{is_admin ? ' as admin' : ''}"

end
puts "A total of #{players.size} players were created"

puts "Starting the seeds.rb file..."