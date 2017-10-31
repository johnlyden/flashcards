# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

harry_deck = Deck.create(name: "Harry Potter Trivia", description: "Test your Harry Potter knowledge you dork")

File.open('db/fixtures/harry.txt').each_slice(2) {|question, answer| Card.create(question: question.chomp, answer: answer.chomp).update_attributes(deck_id: harry_deck.id)}

turtle_deck = Deck.create(name: "Teenage Mutant Ninja Turtles Trivia", description: "Test your Ninja Turtle knowledge you dork")

File.open('db/fixtures/turtles.txt').each_slice(2) {|question, answer| Card.create(question: question.chomp, answer: answer.chomp).update_attributes(deck_id: turtle_deck.id)}

tv = Deck.create(name: "Dope TV Shows", description: "Test your knoweldge of great tv shows from the past")

File.open('db/fixtures/classic_tv.txt').each_slice(2) {|question, answer| Card.create(question: question.chomp, answer: answer.chomp).update_attributes(deck_id: tv.id)}
