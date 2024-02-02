# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning up database..."
Organization.destroy_all
Event.destroy_all
puts "Database cleaned"


festival = Organization.create(
    name: "Festival de Canne",
    email: "festival@canne.fr",
    phone: "0494303030",
    website: "www.canne.fr"
)
jeux = Event.create(
    title: "Festival des jeux",
    address: "1 Bd de la Croisette, 06400 Cannes",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    start_time: "2024-02-23",
    end_time: "2024-02-25",
    registration_code: "QWERTY",
    organization: festival
)

puts "finish"
