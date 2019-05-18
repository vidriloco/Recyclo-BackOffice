# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Material.create(value: "aluminium-can", image_url: "https://media.giphy.com/media/dJ47NVciJCuTy7o5xX/giphy.gif")
Material.create(value: "plastic-pet", enabled: false, image_url: "https://media.giphy.com/media/GcPhfqeGu48g0/giphy.gif")
Material.create(value: "paper-cardboard", enabled: false, image_url: "https://media.giphy.com/media/zCXG6qPHRKrXa/giphy.gif")
Material.create(value: "paper-newspaper", enabled: false, image_url: "https://media.giphy.com/media/3oriOd9e7E0hzfwgF2/giphy.gif")

Avatar.create(name: "Mario Bros", url: "https://media.giphy.com/media/12QMzVeF4QsqTC/giphy.gif")
Avatar.create(name: "Black Gato", url: "https://media.giphy.com/media/GObRHYaUQWf3q/giphy.gif")
Avatar.create(name: "Beyonce", url: "https://media.giphy.com/media/APPbIpIe0xrVe/giphy.gif")
Avatar.create(name: "Captain Planet", url: "https://media.giphy.com/media/KhlVSyjsbx18A/giphy.gif")

Donation.create_fake_donation_given_by("Luisa")
Donation.create_fake_donation_given_by("Manuel")
Donation.create_fake_donation_given_by("Francisco")
Donation.create_fake_donation_given_by("Jonhy")


