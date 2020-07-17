Category.destroy_all
Thematic.destroy_all
Lesson.destroy_all

yoga = Thematic.create!(name: "Yoga")
pilates = Thematic.create!(name: "Pilates")
port = Thematic.create!(name: "Port de Bras")
fitness = Thematic.create!(name: "Fitness")

cours = Category.create!(name: "Cours")
stage = Category.create!(name: "Stage")
coaching = Category.create!(name: "Coaching")

Lesson.create!(name: "Cours de Yoga", price:1500, category: cours, thematic: yoga)
Lesson.create!(name: "Stage automnale", price:2500, category: cours, thematic: yoga)
Lesson.create!(name: "Coaching privé", price:2500, category: coaching, thematic: fitness)
Lesson.create!(name: "Cours de Port de bras", price:1500, category: stage, thematic: port)
Lesson.create!(name: "Stage de Pilates", price:2500, category: stage, thematic: pilates)