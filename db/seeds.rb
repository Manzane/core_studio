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

Lesson.create!(name: "Yoga Vinyasa", capacity: 8, category: cours, thematic: yoga, start_time: DateTime.new(2020,8,24,12,15), duration: 1, color: "blue")
Lesson.create!(name: "Pilates and Flows", capacity: 8, category: cours, thematic: pilates, start_time: DateTime.new(2020,8,25,17), duration: 1, color: "yellow")
Lesson.create!(name: "Port de Bras™", capacity: 8, category: cours, thematic: port, start_time: DateTime.new(2020,8,25,18), duration: 1.25, color: "pink")
Lesson.create!(name: "Yoga Vinyasa", capacity: 8, category: cours, thematic: yoga, start_time: DateTime.new(2020,8,25,19,15), duration: 1, color: "blue")
Lesson.create!(name: "Pilates and Flows", capacity: 8, category: cours, thematic: pilates, start_time: DateTime.new(2020,8,27,18,30), duration: 1, color: "yellow")
Lesson.create!(name: "Yoga Vinyasa", capacity: 8, category: cours, thematic: yoga, start_time: DateTime.new(2020,8,27,19,30), duration: 1, color: "blue")
Lesson.create!(name: "Morning Yoga", capacity: 8, category: cours, thematic: yoga, start_time: DateTime.new(2020,8,28,7,30), duration: 1, color: "green")
Lesson.create!(name: "Pilates and Flows", capacity: 8, category: cours, thematic: pilates, start_time: DateTime.new(2020,8,28,9), duration: 1, color: "yellow")
Lesson.create!(name: "Port de Bras™", capacity: 8, category: cours, thematic: port, start_time: DateTime.new(2020,8,28,10,15), duration: 1.25, color: "pink")
Lesson.create!(name: "Pilates and Flows", capacity: 8, category: cours, thematic: pilates, start_time: DateTime.new(2020,8,28,12,15), duration: 1, color: "yellow")




# Lesson.create!(name: "Coaching privé", capacity: 10, category: coaching, thematic: fitness, start_time: DateTime.new(2020,7,30,15), duration: 1)
# Lesson.create!(name: "Cours de yoga", category: Category.first, thematic: Thematic.first, start_time: DateTime.new(2020,8,5,17), duration: 1, capacity: 10)
# Lesson.create!(name: "Stage Pilates", category: Category.find(8), thematic: Thematic.find(10), start_time: DateTime.new(2020,8,1,10), duration: 2, capacity: 10)
# Lesson.last.create_recurring_events('tuesday', Time.new(2020,9,31), Time.now)
Lesson.first.create_recurring_events('monday', Time.new(2020,12,31), (Lesson.first.start_time + 86400) )

Package.create!(quantity: 1, price: 15, category: cours)
Package.create!(quantity: 10, price: 125, category: cours)
Package.create!(quantity: 20, price: 225, category: cours)
Package.create!(quantity: 30, price: 325, category: cours)
Package.create!(quantity: 50, price: 500, category: cours)

Package.create!(quantity: 1, price: 15, category: stage)
Package.create!(quantity: 10, price: 125, category: stage)
Package.create!(quantity: 20, price: 225, category: stage)
Package.create!(quantity: 30, price: 325, category: stage)
Package.create!(quantity: 50, price: 500, category: stage)

Package.create!(quantity: 1, price: 15, category: coaching)
Package.create!(quantity: 10, price: 125, category: coaching)
Package.create!(quantity: 20, price: 225, category: coaching)
Package.create!(quantity: 30, price: 325, category: coaching)
Package.create!(quantity: 50, price: 500, category: coaching)

# Order.create!(date: Time.now, amount: 1500, state: "en cours", user: test_user, cart: cart.first)