Administrator.destroy_all
User.destroy_all
Credit.destroy_all
Lesson.destroy_all
Category.destroy_all
Thematic.destroy_all


Administrator.create(email: "test@test.com", password: "azerty", first_name:"test", last_name:"admin")
test_user = User.create(email: "test@test.com", password: "azerty", first_name:"test", last_name:"admin")

yoga = Thematic.create!(name: "Yoga")
pilates = Thematic.create!(name: "Pilates")
port = Thematic.create!(name: "Port de Bras")
fitness = Thematic.create!(name: "Fitness")

cours = Category.create!(name: "Cours")
stage = Category.create!(name: "Stage")
coaching = Category.create!(name: "Coaching")

Credit.create(quantity: 10, user: test_user, category: cours)
Credit.create(quantity: 10, user: test_user, category: stage)

Lesson.create!(name: "Cours de Yoga", capacity: 10, category: cours, thematic: yoga, start_time: DateTime.new(2020,7,24,15), end_time: DateTime.new(2020,7,24,17))
Lesson.create!(name: "Stage automnale", capacity: 10, category: cours, thematic: yoga, start_time: DateTime.new(2020,7,25,15), end_time: DateTime.new(2020,7,25,17))
Lesson.create!(name: "Coaching privé", capacity: 10, category: coaching, thematic: fitness, start_time: DateTime.new(2020,7,30,15), end_time: DateTime.new(2020,7,30,17))
Lesson.create!(name: "Cours de Port de bras", capacity: 1, category: stage, thematic: port, start_time: DateTime.new(2020,7,27,15), end_time: DateTime.new(2020,7,27,17))
Lesson.create!(name: "Stage de Pilates", capacity: 10, category: stage, thematic: pilates, start_time: DateTime.new(2020,7,28,15), end_time: DateTime.new(2020,7,28,17))





Package.create!(quantity: 1, price: 1500, category: cours)
Package.create!(quantity: 10, price: 12500, category: cours)
Package.create!(quantity: 20, price: 22500, category: cours)
Package.create!(quantity: 30, price: 32500, category: cours)
Package.create!(quantity: 50, price: 50000, category: cours)

Package.create!(quantity: 1, price: 1500, category: stage)
Package.create!(quantity: 10, price: 12500, category: stage)
Package.create!(quantity: 20, price: 22500, category: stage)
Package.create!(quantity: 30, price: 32500, category: stage)
Package.create!(quantity: 50, price: 50000, category: stage)

Package.create!(quantity: 1, price: 1500, category: coaching)
Package.create!(quantity: 10, price: 12500, category: coaching)
Package.create!(quantity: 20, price: 22500, category: coaching)
Package.create!(quantity: 30, price: 32500, category: coaching)
Package.create!(quantity: 50, price: 50000, category: coaching)

# Order.create!(date: Time.now, amount: 1500, state: "en cours", user: test_user, cart: cart.first)