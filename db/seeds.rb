# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Artist.create!(first_name: 'Sam', last_name: 'Thomas', genre: 'rock')
# Artist.create!(first_name: 'Sarah', last_name: 'Jones', genre: 'pop')
# Artist.create!(first_name: 'Joe', last_name: 'Smith', genre: 'country')
# Artist.create!(first_name: 'Jen', last_name: 'Adams', genre: 'folk')